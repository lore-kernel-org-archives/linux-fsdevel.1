Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB8C25228D
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786354838; cv=none; b=YI6jvAI90L52v5ZI5tKq7jvdmhmrN8hgxTtvYH/z9eEh221O+aTQ9zW++NJszxjIpNW4Jyl6I+OyzaAkf2QQ+Up2x+SRrEw4ThkEOnLvc6oDsRFMUJOyPVSg1Di6wAxW1lomoW7qHdVywnkjgZiog5Qcfhe9WmnD882K7gsYgoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786354838; c=relaxed/simple;
	bh=9h6TBAA30bDwT9vAIlVT+dfmRpfq5fTWQXT30LxWci8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dBnVjGlA18GRaDUv5h66rWyONQn2azmVtkmzws7BNvRqsiCgMox7GPVWPoKWLE+g7HYRGpsIwIZ0o3EipwFz2XnGdHcO7lxIQM1GwrLDWqvYXTuOqvRI8PjjQDdbMeS1JbiEfOgh8waqcNhlg9fYAVPKVSjF1DxcnmXkSzhnEOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJpXp03C; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJpXp03C"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38511175ad3so1508189a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 02:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786354836; x=1786959636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h8TjGG7W8xBATTSwzzjsDpLSfAeA/sVM6NcS21BdVcE=;
        b=pJpXp03C60Xpgu+0op/sT1lzBBopKWbPmp9uUuLuT8AMfab+i3YFFcCN4GALKAnnYx
         S+b4xaGI082XoR4WSiW9lOSCvr6MpaWA1DAJxB+IORXYfJRXfFDek6eXIW3ji7m8Jobw
         Bn065eKVq6QDlroU6vjnDjLEc/xIqy/AtI/NUOeNsSZMudpLqQ3XaeuxswLhtZ46jM5W
         aIc91nu1ez20d01f7PiNnIkqKuYRLdY+wLbX1Le7hICV+nTPIWIR0EWid5fd4NiL5jtS
         T0AuZvBVUff0ve6gVI3IyR7QMeMPRinpxu5+RohUpK0csLcLTJpH0o4c9rZ/ay73neKz
         91nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786354836; x=1786959636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h8TjGG7W8xBATTSwzzjsDpLSfAeA/sVM6NcS21BdVcE=;
        b=JZjYKtgOaghTl0SdLMw5Nuzm+euEXPf0FkVZm0oXv0nbDVmdGNiG+yDQzrdfCZz/U7
         1hJe7GAnECG54o4wVuhvDzMgLchYU8XEGsMp9+9lF0cxqGBwQ/lbuWsX4JEbfoPvSw4k
         x14VTCrfVdmT5ohYS3AY6NwUuXKNdYlhsSmC01QR9urar8Pxw+nx4C0m8Z4oxetJ73oQ
         4uSYk9JSsSu5pw8QqgFehLSi4rBesz65JquZDqkzkzG+ex22dJsA2gcWKNHpg9bKHVLh
         7MJAHRJHTQl2e+goP3smPrSxESBoWb79dNGoKSyM6LXFPfJttzsggNkesUEZt+5aIX9s
         r27A==
X-Forwarded-Encrypted: i=1; AHgh+RpkYLRIf+2NGFVtf1EbR1MA8Ui69pjIaUR5hc5vwXZ5AJ9PPf48ppg1+lVOuKgo4HODjs3RzPDs55cNunDp@vger.kernel.org
X-Gm-Message-State: AOJu0YzKNOemIsQl5wmm5AqElA8fAi+tSrGInatnrFPXwQ7pGVh19Gkf
	15/zhau4npxjHvqL1+8sTG1bASSeiLOAf3DLuWaTGVW2N9wHs6AxZgHf
X-Gm-Gg: AR+sD11vo0wXjJyYKYL0ccyyx1ylXfzq5/PmI5KvGGS9pnXlq458q/GG3tmSo1CA6QK
	vkJKwAUWtaqn43osk/HJmZokOs+wagSVz/FhPiRs/3mxepvkIntGUOgHKesFA+/UAkCUqODy8YT
	doyLbEzonXj718zyjoJ7/ycXni6PtAve1xmpW5aUYsHZQkvVf1bq/CvZdxHSEmS2yJoJGTIY0nG
	s8/iF+NzlpeYwIr58L6pJ4dlT9XViPsu9BjssabGbUbEf8Us2HpGVpA/BS/9Ln9X3sPNG9TF0ZK
	clf7r08BUcqhTQvP1AWD0p99rzp+hu/6+jqIDriQRAIi25sQ1WK62rZuxks7joWI9rM/FliVtJR
	jjJwi03StzOmipmK9pwIznPmzHlNE53f/qkGm74QN5OQUzjpPsPJ4uSj1+PcsNQAHmZaosm+uPr
	umZXc7QIzuSoD2GZEoacwHC0wBGOHFBGF5aeqZAoJ24Ne2JfRHXQpACUzAvEnDJIvbpfESX+/B2
	NUDvAjP7Swmb1TgXPLIesQcclGMeBWCZ7RMVGA=
X-Received: by 2002:a17:90b:578e:b0:383:5a16:bd70 with SMTP id 98e67ed59e1d1-3903c5ebc8cmr43653966a91.16.1786354835714;
        Mon, 10 Aug 2026 02:40:35 -0700 (PDT)
Received: from bj-kjy-standalone-gaoxiang17.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085de9f6asm14070527a91.7.2026.08.10.02.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 02:40:35 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
X-Google-Original-From: Xiang Gao <gaoxiang17@xiaomi.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	liam@infradead.org,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Gao <gaoxiang17@xiaomi.com>
Subject: [PATCH] tracing: report buffer memory in /proc/meminfo
Date: Mon, 10 Aug 2026 17:40:25 +0800
Message-Id: <20260810094025.136705-1-gaoxiang17@xiaomi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report the data capacity of all ftrace ring buffers through a new Ftrace
field in /proc/meminfo. Include the main and snapshot buffers of the
global trace array and all tracing instances, while leaving ring-buffer
metadata accounted for by Slab.

Keep the interface as a no-op when tracing is disabled so /proc/meminfo
does not gain a configuration dependency on tracing.

Tested on arm64 QEMU:

  CONFIG_TRACING=n:                   0 kB
  Global resize/restore:          7 -> 4099 -> 7 kB
  Instance and snapshot lifecycle: 15 -> 1434 -> 2836 -> 1434 -> 15 kB

Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
---
 fs/proc/meminfo.c     |  3 +++
 include/linux/trace.h |  5 +++++
 kernel/trace/trace.c  | 30 ++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index b2813ff13cb2..96a38ffc4e35 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -18,6 +18,7 @@
 #include <linux/cma.h>
 #endif
 #include <linux/zswap.h>
+#include <linux/trace.h>
 #include <asm/page.h>
 #include "internal.h"
 
@@ -108,6 +109,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "Slab:           ", sreclaimable + sunreclaim);
 	show_val_kb(m, "SReclaimable:   ", sreclaimable);
 	show_val_kb(m, "SUnreclaim:     ", sunreclaim);
+	seq_printf(m, "Ftrace:         %8lu kB\n",
+		   ftrace_buffer_total_size() >> 10);
 	seq_printf(m, "KernelStack:    %8lu kB\n",
 		   global_node_page_state(NR_KERNEL_STACK_KB));
 #ifdef CONFIG_SHADOW_CALL_STACK
diff --git a/include/linux/trace.h b/include/linux/trace.h
index 7eaad857dee0..f9935231560c 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -53,6 +53,7 @@ int trace_array_init_printk(struct trace_array *tr);
 void trace_array_put(struct trace_array *tr);
 struct trace_array *trace_array_get_by_name(const char *name, const char *systems);
 int trace_array_destroy(struct trace_array *tr);
+unsigned long ftrace_buffer_total_size(void);
 
 /* For osnoise tracer */
 int osnoise_arch_register(void);
@@ -92,6 +93,10 @@ static inline int trace_array_destroy(struct trace_array *tr)
 {
 	return 0;
 }
+static inline unsigned long ftrace_buffer_total_size(void)
+{
+	return 0;
+}
 #endif	/* CONFIG_TRACING */
 
 #endif	/* _LINUX_TRACE_H */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 01a5e87af299..f0bb553e3688 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5769,6 +5769,36 @@ tracing_total_entries_read(struct file *filp, char __user *ubuf,
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
 }
 
+static unsigned long trace_array_buffer_size(struct array_buffer *buf)
+{
+	unsigned long size = 0;
+	int cpu;
+
+	if (!buf->buffer)
+		return 0;
+
+	for_each_tracing_cpu(cpu)
+		size += ring_buffer_size(buf->buffer, cpu);
+
+	return size;
+}
+
+unsigned long ftrace_buffer_total_size(void)
+{
+	struct trace_array *tr;
+	unsigned long size = 0;
+
+	guard(mutex)(&trace_types_lock);
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		size += trace_array_buffer_size(&tr->array_buffer);
+#ifdef CONFIG_TRACER_SNAPSHOT
+		size += trace_array_buffer_size(&tr->snapshot_buffer);
+#endif
+	}
+
+	return size;
+}
+
 #define LAST_BOOT_HEADER ((void *)1)
 
 static void *l_next(struct seq_file *m, void *v, loff_t *pos)
-- 
2.34.1

