Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0128736EA8F;
	Sun, 29 Mar 2026 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774802078; cv=none; b=irrIkURboExniS+UNCOUVTJOWX+tbX9wZJvPCDkOJdNtlCfrNAwy/51zQQjbKKetk1YB5bsU3mRYjdvw2moHQ9Bu4qVs4PWkwo+E7vWuup621FB1zbJjQkAH7cAIPgfA1NL9HicTsogDDYSeRjKmDQHkS/hLbTzLjNxR0tlHhHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774802078; c=relaxed/simple;
	bh=nTOKHUR2ROWvul6nIWZeDg1k40hab5DcwyUy2jqATz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPvmXhtSOS5YzL8XWoyHD8t80+tlhyNELww7DKOr4tSlnFNxjx/ulH6MRY+xkqEmERZAIwOQHy8+4AETFaIMNcPjhProz9a2fzTIFpM9QzDWB0v28x9Hb27s8GmPTO85K8R5dIE+SSrgYaGfWVXBHBJ8cPuqhlKVmC5u5svBzaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l8EhYKwh; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l8EhYKwh"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD90C4387;
	Sun, 29 Mar 2026 09:34:30 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E2CF3F915;
	Sun, 29 Mar 2026 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774802076; bh=nTOKHUR2ROWvul6nIWZeDg1k40hab5DcwyUy2jqATz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l8EhYKwh4KvTFDvgxYU8Ji0ZxHSnNmaIZldFf/e+So+Plpnp4d8AYD7RNHMuEA/4e
	 lfn5GrElCeDiZQ0rG1D4G4lY3LCFmQuz7kzhQ2a+Z1C+bjsPtsDZDywrGFWCEA+ZDZ
	 fn+t6EMEa4lzQ1oqNZwmDiLvUIMgU1wjloF7YAXA=
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sudeep.holla@kernel.org,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	dan.carpenter@linaro.org,
	d-gole@ti.com,
	jonathan.cameron@huawei.com,
	elif.topuz@arm.com,
	lukasz.luba@arm.com,
	philip.radford@arm.com,
	brauner@kernel.org,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 07/24] include: trace: Add Telemetry trace events
Date: Sun, 29 Mar 2026 17:33:18 +0100
Message-ID: <20260329163337.637393-8-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329163337.637393-1-cristian.marussi@arm.com>
References: <20260329163337.637393-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add custom traces to report Telemetry failed accesses and to report when DE
values are updated internally after a notification is processed.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 include/trace/events/scmi.h | 48 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/scmi.h b/include/trace/events/scmi.h
index 703b7bb68e44..b70b26e467b8 100644
--- a/include/trace/events/scmi.h
+++ b/include/trace/events/scmi.h
@@ -7,7 +7,8 @@
 
 #include <linux/tracepoint.h>
 
-#define TRACE_SCMI_MAX_TAG_LEN	6
+#define TRACE_SCMI_MAX_TAG_LEN		6
+#define TRACE_SCMI_TLM_MAX_TAG_LEN	16
 
 TRACE_EVENT(scmi_fc_call,
 	TP_PROTO(u8 protocol_id, u8 msg_id, u32 res_id, u32 val1, u32 val2),
@@ -180,6 +181,51 @@ TRACE_EVENT(scmi_msg_dump,
 		  __entry->tag, __entry->msg_id, __entry->seq, __entry->status,
 		__print_hex_str(__get_dynamic_array(cmd), __entry->len))
 );
+
+TRACE_EVENT(scmi_tlm_access,
+	TP_PROTO(u64 de_id, unsigned char *tag, u64 startm, u64 endm),
+	TP_ARGS(de_id, tag, startm, endm),
+
+	TP_STRUCT__entry(
+		__field(u64, de_id)
+		__array(char, tag, TRACE_SCMI_TLM_MAX_TAG_LEN)
+		__field(u64, startm)
+		__field(u64, endm)
+	),
+
+	TP_fast_assign(
+		__entry->de_id = de_id;
+		strscpy(__entry->tag, tag, TRACE_SCMI_TLM_MAX_TAG_LEN);
+		__entry->startm = startm;
+		__entry->endm = endm;
+	),
+
+	TP_printk("de_id=0x%llX [%s] - startm=%016llX endm=%016llX",
+		  __entry->de_id, __entry->tag, __entry->startm, __entry->endm)
+);
+
+TRACE_EVENT(scmi_tlm_collect,
+	TP_PROTO(u64 ts, u64 de_id, u64 value, unsigned char *tag),
+	TP_ARGS(ts, de_id, value, tag),
+
+	TP_STRUCT__entry(
+		__field(u64, ts)
+		__field(u64, de_id)
+		__field(u64, value)
+		__array(char, tag, TRACE_SCMI_TLM_MAX_TAG_LEN)
+	),
+
+	TP_fast_assign(
+		__entry->ts = ts;
+		__entry->de_id = de_id;
+		__entry->value = value;
+		strscpy(__entry->tag, tag, TRACE_SCMI_TLM_MAX_TAG_LEN);
+	),
+
+	TP_printk("ts=%llu  de_id=0x%04llX  value=%016llu [%s]",
+		  __entry->ts, __entry->de_id, __entry->value, __entry->tag)
+);
+
 #endif /* _TRACE_SCMI_H */
 
 /* This part must be outside protection */
-- 
2.53.0

