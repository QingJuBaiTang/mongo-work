package oracle2Mongo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import oracle.jdbc.pool.OracleDataSource;
import org.springframework.jdbc.support.JdbcUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wanglei on 16/7/25.
 */
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class OracleStream {
    private String          url;
    private String          sql;
    private RowProcess      process;
    private ProcessCallback callback;

    public void processDataStream() {
        int FETCH_SIZE = 10_0000;

        Connection        connection = null;
        PreparedStatement ps         = null;
        ResultSet         rs         = null;
        try {
            OracleDataSource dataSource = new OracleDataSource();
            dataSource.setURL(url);

            connection = dataSource.getConnection();
            ps         = connection.prepareStatement(sql, ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
            ps.setFetchSize(FETCH_SIZE);

            rs = ps.executeQuery(sql);

            ResultSetMetaData mdrs         = rs.getMetaData();
            List<String>      columnLabels = new ArrayList<>();

            for (int i = 1; i <= mdrs.getColumnCount(); i++) {
                columnLabels.add(mdrs.getColumnLabel(i));
            }


            while (true) {
                Map row0 = new HashMap();
                Map row1 = new HashMap();
                if(rs.next()) {
                    for (int j = 0; j < columnLabels.size(); j++) {
                        row0.put(columnLabels.get(j), rs.getObject(columnLabels.get(j)));
                    }
                }

                if (rs.next()) {
                    for (int j = 0; j < columnLabels.size(); j++) {
                        row1.put(columnLabels.get(j), rs.getObject(columnLabels.get(j)));
                    }
                }

                if (row0.isEmpty() && row1.isEmpty()) break;

                if (!row0.isEmpty() && row1.isEmpty()) {
                    process.processOneRow(row0);
                    callback.callAfterProcess();

                    process.setLastRow();

                    process.processOneRow(row1);
                    callback.callAfterProcess();
                }

                if (row0.isEmpty() && !row1.isEmpty()) {
                    process.processOneRow(row0);
                    callback.callAfterProcess();

                    process.processOneRow(row1);
                    callback.callAfterProcess();
                }

            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtils.closeResultSet(rs);
            JdbcUtils.closeStatement(ps);
            JdbcUtils.closeConnection(connection);
        }

    }
}
