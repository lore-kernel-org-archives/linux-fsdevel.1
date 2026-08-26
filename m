Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C13480960;
	Wed, 26 Aug 2026 19:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773480; cv=none; b=lslmwM6qFkNkSjgtz5AkPpRr8zgvdwi/DzCJqlPgiHNpkd/VycZrL133Ype9vjyR2W95AcApHW0/MFiPNqWofEsOuUD/wYD8sFVC83Opwf8Wr9P1IUlp9G83MlsNF5jDRi/mHqj2rK6xa06yl5D2yG0Dzx+9vTyfsIk9owF7T8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773480; c=relaxed/simple;
	bh=1uO7R8vQ4NXChie3cI9o7w5dyXnQ6FdEw8W8/ZvKBKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYsB9eQyq5Fo6ZgCHxptD1PonudDHQwgYoW8on9Xchcx3N4GYgzdyonC+HJxMKQqjN/5AvKAXUKzaHVJYKjCGK/26XG6EUVeF5BznS9hiUtycVyYJ1SGgaAw7hGF4mdcqGzOu9chFa1OQKVs/XBQOVt1ET/icrmDPT+XNyLeArI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyaE0LD4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyaE0LD4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6497E1F00A3D;
	Wed, 26 Aug 2026 19:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773453;
	bh=sz2i8Jxz+uYgq/eqQx8893HCcIiUPIUWQomhwjuhu5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fyaE0LD45L+AAzYvb5wH6fj+2OLSgzjzwbCCJ4jPLLff4SVtYoNPwamvLRXWEsJO6
	 cmjf7zy7hjTCum/wGk1MHjTkL1BBhPzZoet0GnK2Ha/78qS1G8SFiyN7P6c28Qw57B
	 xaRCwEshVHlQwieZWICWD9QRAYuy1Ika5lBdXrcvHQmOXC/RHPqB/sTexUvxk7IqnT
	 glvmZLWGNgvG0dyuxKSfgvrwIIDdo+ETlMnKN9vc5iMsFxkMPUJEedTE2lKQRax66j
	 L9nCMd3ENqPtmOQOjEG2835aGPyvcB+i7bkhFPH4mgd8O/Rty/4iydqbvVK4NaTGg3
	 gACoDjnRUeyyg==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 30/30] sysctl: parport: use sysctl_field for dynamic sysctls
Date: Wed, 26 Aug 2026 21:42:34 +0200
Message-ID: <f121c4391e022fb9c11cecede06dbf187e86264c.1787771905.git.legion@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787771905.git.legion@kernel.org>
References: <cover.1787771905.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parport builds per-port and per-device sysctl tables by cloning template
ctl_table arrays and then patching the data and extra pointers at fixed
indexes. That keeps the static table definitions writable in practice
and makes the registration path depend on the exact order of the table
entries.

Use sysctl_field for those tables instead. The per-object state is
supplied through the registration context, so the table layout can stay
static and the data pointers are resolved when proc_sysctl builds the
effective ctl_table. This removes the need to duplicate the tables for
every parport object and keeps the per-entry state binding next to the
entry definition.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 drivers/parport/procfs.c | 317 ++++++++++++++++++---------------------
 fs/proc/proc_sysctl.c    |  11 ++
 include/linux/parport.h  |   6 +-
 include/linux/sysctl.h   |  12 ++
 4 files changed, 171 insertions(+), 175 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 3880460e67f2..6348d1342069 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -236,147 +236,134 @@ do {									\
 	return 0;
 }
 
-static const unsigned long parport_min_timeslice_value =
+static unsigned long parport_min_timeslice_value =
 PARPORT_MIN_TIMESLICE_VALUE;
 
-static const unsigned long parport_max_timeslice_value =
+static unsigned long parport_max_timeslice_value =
 PARPORT_MAX_TIMESLICE_VALUE;
 
-static const  int parport_min_spintime_value =
+static int parport_min_spintime_value =
 PARPORT_MIN_SPINTIME_VALUE;
 
-static const int parport_max_spintime_value =
+static int parport_max_spintime_value =
 PARPORT_MAX_SPINTIME_VALUE;
 
+struct parport_ctl_context {
+	struct sysctl_context context;
+	struct parport *port;
+};
 
-struct parport_sysctl_table {
-	struct ctl_table_header *port_header;
-	struct ctl_table_header *devices_header;
-#ifdef CONFIG_PARPORT_1284
-	struct ctl_table vars[10];
-#else
-	struct ctl_table vars[5];
-#endif /* IEEE 1284 support */
-	struct ctl_table device_dir[1];
+struct pardevice_ctl_context {
+	struct sysctl_context context;
+	struct pardevice *device;
 };
 
-static const struct parport_sysctl_table parport_sysctl_template = {
-	.port_header = NULL,
-	.devices_header = NULL,
-	{
-		{
-			.procname	= "spintime",
-			.data		= NULL,
-			.maxlen		= sizeof(int),
-			.mode		= 0644,
-			.proc_handler	= proc_dointvec_minmax,
-			.extra1		= (void*) &parport_min_spintime_value,
-			.extra2		= (void*) &parport_max_spintime_value
-		},
-		{
-			.procname	= "base-addr",
-			.data		= NULL,
-			.maxlen		= 0,
-			.mode		= 0444,
-			.proc_handler	= do_hardware_base_addr
-		},
-		{
-			.procname	= "irq",
-			.data		= NULL,
-			.maxlen		= 0,
-			.mode		= 0444,
-			.proc_handler	= do_hardware_irq
-		},
-		{
-			.procname	= "dma",
-			.data		= NULL,
-			.maxlen		= 0,
-			.mode		= 0444,
-			.proc_handler	= do_hardware_dma
-		},
-		{
-			.procname	= "modes",
-			.data		= NULL,
-			.maxlen		= 0,
-			.mode		= 0444,
-			.proc_handler	= do_hardware_modes
-		},
+static int *parport_spintime_data(const struct sysctl_context *ctx)
+{
+	const struct parport_ctl_context *parport_ctx =
+		container_of(ctx, struct parport_ctl_context, context);
+
+	return &parport_ctx->port->spintime;
+}
+
+static void *pardevice_timeslice_data(const struct sysctl_context *ctx)
+{
+	const struct pardevice_ctl_context *pardevice_ctx =
+		container_of(ctx, struct pardevice_ctl_context, context);
+
+	return &pardevice_ctx->device->timeslice;
+}
+
+static void *parport_data(const struct sysctl_context *ctx)
+{
+	const struct parport_ctl_context *parport_ctx =
+		container_of(ctx, struct parport_ctl_context, context);
+
+	return parport_ctx->port;
+}
+
+static void *parport_min_timeslice_data(const struct sysctl_context *ctx)
+{
+	return &parport_min_timeslice_value;
+}
+
+static void *parport_max_timeslice_data(const struct sysctl_context *ctx)
+{
+	return &parport_max_timeslice_value;
+}
+
 #ifdef CONFIG_PARPORT_1284
-		{
-			.procname	= "autoprobe",
-			.data		= NULL,
-			.maxlen		= 0,
-			.mode		= 0444,
-			.proc_handler	= do_autoprobe
-		},
-		{
-			.procname	= "autoprobe0",
-			.data		= NULL,
-			.maxlen		= 0,
-			.mode		= 0444,
-			.proc_handler	= do_autoprobe
-		},
-		{
-			.procname	= "autoprobe1",
-			.data		= NULL,
-			.maxlen		= 0,
-			.mode		= 0444,
-			.proc_handler	= do_autoprobe
-		},
-		{
-			.procname	= "autoprobe2",
-			.data		= NULL,
-			.maxlen		= 0,
-			.mode		= 0444,
-			.proc_handler	= do_autoprobe
-		},
-		{
-			.procname	= "autoprobe3",
-			.data		= NULL,
-			.maxlen		= 0,
-			.mode		= 0444,
-			.proc_handler	= do_autoprobe
-		},
-#endif /* IEEE 1284 support */
-	},
-	{
-		{
-			.procname	= "active",
-			.data		= NULL,
-			.maxlen		= 0,
-			.mode		= 0444,
-			.proc_handler	= do_active_device
-		},
-	},
+#define PARPORT_PROBE_DATA(index)							\
+static void *parport_probe_info_ ## index ## _data(const struct sysctl_context *ctx)	\
+{											\
+	const struct parport_ctl_context *parport_ctx =					\
+		container_of(ctx, struct parport_ctl_context, context);			\
+	return &parport_ctx->port->probe_info[index];					\
+}
+
+PARPORT_PROBE_DATA(0)
+PARPORT_PROBE_DATA(1)
+PARPORT_PROBE_DATA(2)
+PARPORT_PROBE_DATA(3)
+PARPORT_PROBE_DATA(4)
+#endif
+
+#define PARPORT_PORT_ENTRY(name, proc)					\
+	{								\
+		.procname	= name,					\
+		.mode		= 0444,					\
+		.type		= SYSCTL_FIELD_CUSTOM,			\
+		.ctl_custom	= {					\
+			.proc_handler	= proc,				\
+			.extra1		= parport_data,			\
+			.maxlen		= 0,				\
+		},							\
+	}
+
+#define PARPORT_PROBE_ENTRY(name, index)				\
+	{								\
+		.procname	= name,					\
+		.mode		= 0444,					\
+		.type		= SYSCTL_FIELD_CUSTOM,			\
+		.ctl_custom	= {					\
+			.proc_handler	= do_autoprobe,			\
+			.extra2		= parport_probe_info_ ## index ## _data, \
+			.maxlen		= 0,				\
+		},							\
+	}
+
+static const struct sysctl_field parport_sysctl_table[] = {
+	SYSCTL_FIELD_STATIC_INT_MINMAX("spintime", 0644, parport_spintime_data,
+				       &parport_min_spintime_value,
+				       &parport_max_spintime_value),
+	PARPORT_PORT_ENTRY("base-addr", do_hardware_base_addr),
+	PARPORT_PORT_ENTRY("irq", do_hardware_irq),
+	PARPORT_PORT_ENTRY("dma", do_hardware_dma),
+	PARPORT_PORT_ENTRY("modes", do_hardware_modes),
+#ifdef CONFIG_PARPORT_1284
+	PARPORT_PROBE_ENTRY("autoprobe", 0),
+	PARPORT_PROBE_ENTRY("autoprobe0", 1),
+	PARPORT_PROBE_ENTRY("autoprobe1", 2),
+	PARPORT_PROBE_ENTRY("autoprobe2", 3),
+	PARPORT_PROBE_ENTRY("autoprobe3", 4),
+#endif
 };
 
-struct parport_device_sysctl_table
-{
-	struct ctl_table_header *sysctl_header;
-	struct ctl_table vars[1];
-	struct ctl_table device_dir[1];
+static const struct sysctl_field parport_device_dir_table[] = {
+	PARPORT_PORT_ENTRY("active", do_active_device),
 };
 
-static const struct parport_device_sysctl_table
-parport_device_sysctl_template = {
-	.sysctl_header = NULL,
+static const struct sysctl_field parport_device_sysctl_table[] = {
 	{
-		{
-			.procname 	= "timeslice",
-			.data		= NULL,
-			.maxlen		= sizeof(unsigned long),
-			.mode		= 0644,
+		.procname	= "timeslice",
+		.mode		= 0644,
+		.type		= SYSCTL_FIELD_CUSTOM,
+		.ctl_custom	= {
 			.proc_handler	= proc_doulongvec_ms_jiffies_minmax,
-			.extra1		= (void*) &parport_min_timeslice_value,
-			.extra2		= (void*) &parport_max_timeslice_value
-		},
-	},
-	{
-		{
-			.procname	= NULL,
-			.data		= NULL,
-			.maxlen		= 0,
-			.mode		= 0555,
+			.data		= pardevice_timeslice_data,
+			.extra1		= parport_min_timeslice_data,
+			.extra2		= parport_max_timeslice_data,
+			.maxlen		= sizeof(unsigned long),
 		},
 	}
 };
@@ -414,35 +401,27 @@ parport_default_sysctl_table = {
 
 int parport_proc_register(struct parport *port)
 {
-	struct parport_sysctl_table *t;
+	struct parport_ctl_context ctx = {
+		.port = port,
+	};
+	struct ctl_table_header *hdr;
 	char *tmp_dir_path;
-	int i, err = 0;
-
-	t = kmemdup(&parport_sysctl_template, sizeof(*t), GFP_KERNEL);
-	if (t == NULL)
-		return -ENOMEM;
-
-	t->device_dir[0].extra1 = port;
-
-	t->vars[0].data = &port->spintime;
-	for (i = 0; i < 5; i++) {
-		t->vars[i].extra1 = port;
-#ifdef CONFIG_PARPORT_1284
-		t->vars[5 + i].extra2 = &port->probe_info[i];
-#endif /* IEEE 1284 support */
-	}
+	int err = 0;
 
 	tmp_dir_path = kasprintf(GFP_KERNEL, "dev/parport/%s/devices", port->name);
 	if (!tmp_dir_path) {
 		err = -ENOMEM;
-		goto exit_free_t;
+		goto out;
 	}
 
-	t->devices_header = register_sysctl(tmp_dir_path, t->device_dir);
-	if (t->devices_header == NULL) {
+	hdr = register_sysctl_fields_sz(tmp_dir_path, parport_device_dir_table,
+					ARRAY_SIZE(parport_device_dir_table),
+					&ctx.context, sizeof(ctx));
+	if (hdr == NULL) {
 		err = -ENOENT;
 		goto  exit_free_tmp_dir_path;
 	}
+	port->sysctl_devices_header = hdr;
 
 	kfree(tmp_dir_path);
 
@@ -452,83 +431,75 @@ int parport_proc_register(struct parport *port)
 		goto unregister_devices_h;
 	}
 
-	t->port_header = register_sysctl(tmp_dir_path, t->vars);
-	if (t->port_header == NULL) {
+	hdr = register_sysctl_fields_sz(tmp_dir_path, parport_sysctl_table,
+					ARRAY_SIZE(parport_sysctl_table),
+					&ctx.context, sizeof(ctx));
+	if (hdr == NULL) {
 		err = -ENOENT;
 		goto unregister_devices_h;
 	}
-
-	port->sysctl_table = t;
+	port->sysctl_table = hdr;
 
 	kfree(tmp_dir_path);
 	return 0;
 
 unregister_devices_h:
-	unregister_sysctl_table(t->devices_header);
+	unregister_sysctl_table(port->sysctl_devices_header);
+	port->sysctl_devices_header = NULL;
 
 exit_free_tmp_dir_path:
 	kfree(tmp_dir_path);
 
-exit_free_t:
-	kfree(t);
+out:
 	return err;
 }
 
 int parport_proc_unregister(struct parport *port)
 {
+	if (port->sysctl_devices_header) {
+		unregister_sysctl_table(port->sysctl_devices_header);
+		port->sysctl_devices_header = NULL;
+	}
 	if (port->sysctl_table) {
-		struct parport_sysctl_table *t = port->sysctl_table;
+		unregister_sysctl_table(port->sysctl_table);
 		port->sysctl_table = NULL;
-		unregister_sysctl_table(t->devices_header);
-		unregister_sysctl_table(t->port_header);
-		kfree(t);
 	}
 	return 0;
 }
 
 int parport_device_proc_register(struct pardevice *device)
 {
-	struct parport_device_sysctl_table *t;
+	struct pardevice_ctl_context ctx = {
+		.device = device,
+	};
 	struct parport * port = device->port;
 	char *tmp_dir_path;
 	int err = 0;
-	
-	t = kmemdup(&parport_device_sysctl_template, sizeof(*t), GFP_KERNEL);
-	if (t == NULL)
-		return -ENOMEM;
 
 	/* Allocate a buffer for two paths: dev/parport/PORT/devices/DEVICE. */
 	tmp_dir_path = kasprintf(GFP_KERNEL, "dev/parport/%s/devices/%s", port->name, device->name);
 	if (!tmp_dir_path) {
 		err = -ENOMEM;
-		goto exit_free_t;
+		goto out;
 	}
 
-	t->vars[0].data = &device->timeslice;
-
-	t->sysctl_header = register_sysctl(tmp_dir_path, t->vars);
-	if (t->sysctl_header == NULL) {
-		kfree(t);
-		t = NULL;
-	}
-	device->sysctl_table = t;
+	device->sysctl_table =
+		register_sysctl_fields_sz(tmp_dir_path, parport_device_sysctl_table,
+				       ARRAY_SIZE(parport_device_sysctl_table),
+				       &ctx.context, sizeof(ctx));
 
 	kfree(tmp_dir_path);
 	return 0;
 
-exit_free_t:
-	kfree(t);
-
+out:
 	return err;
 }
 
 int parport_device_proc_unregister(struct pardevice *device)
 {
 	if (device->sysctl_table) {
-		struct parport_device_sysctl_table *t = device->sysctl_table;
+		unregister_sysctl_table(device->sysctl_table);
 		device->sysctl_table = NULL;
-		unregister_sysctl_table(t->sysctl_header);
-		kfree(t);
 	}
 	return 0;
 }
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 88d3cc79fc33..c715f625a410 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1714,6 +1714,17 @@ struct ctl_table_header *register_sysctl_sz(const char *path, const struct ctl_t
 }
 EXPORT_SYMBOL(register_sysctl_sz);
 
+struct ctl_table_header *register_sysctl_fields_sz(const char *path,
+						   const struct sysctl_field *fields,
+						   size_t field_count,
+						   const struct sysctl_context *ctx,
+						   size_t ctx_size)
+{
+	return __register_sysctl_fields(&sysctl_table_root.default_set, path,
+					fields, field_count, ctx, ctx_size);
+}
+EXPORT_SYMBOL(register_sysctl_fields_sz);
+
 /**
  * __register_sysctl_init() - register sysctl table to path
  * @path: path name for sysctl base. If that path doesn't exist we will create
diff --git a/include/linux/parport.h b/include/linux/parport.h
index 464c2ad28039..ea3dd405ea3c 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -20,6 +20,7 @@
 /* Define this later. */
 struct parport;
 struct pardevice;
+struct ctl_table_header;
 
 struct pc_parport_state {
 	unsigned int ctr;
@@ -151,7 +152,7 @@ struct pardevice {
 	unsigned long waiting;		 /* long req'd for set_bit --RR */
 	struct pardevice *waitprev;
 	struct pardevice *waitnext;
-	void * sysctl_table;
+	struct ctl_table_header *sysctl_table;
 };
 
 #define to_pardevice(n) container_of(n, struct pardevice, dev)
@@ -223,7 +224,8 @@ struct parport {
 	struct timer_list timer;
 	unsigned int flags;
 
-	void *sysctl_table;
+	struct ctl_table_header *sysctl_table;
+	struct ctl_table_header *sysctl_devices_header;
 	struct parport_device_info probe_info[5]; /* 0-3 + non-IEEE1284.3 */
 	struct ieee1284_info ieee1284;
 
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 6cf2ef4f13e8..b98f1ee94df2 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -506,6 +506,10 @@ struct ctl_table_header *
 __register_sysctl_fields(struct ctl_table_set *set, const char *path,
 			 const struct sysctl_field *fields, size_t field_count,
 			 const struct sysctl_context *ctx, size_t ctx_size);
+struct ctl_table_header *
+register_sysctl_fields_sz(const char *path,
+			  const struct sysctl_field *fields, size_t field_count,
+			  const struct sysctl_context *ctx, size_t ctx_size);
 struct ctl_table_header *register_sysctl_sz(const char *path, const struct ctl_table *table,
 					    size_t table_size);
 void unregister_sysctl_table(struct ctl_table_header * table);
@@ -541,6 +545,14 @@ static inline struct ctl_table_header *register_sysctl_sz(const char *path,
 	return NULL;
 }
 
+static inline struct ctl_table_header *
+register_sysctl_fields_sz(const char *path,
+			  const struct ctl_field *fields, size_t field_count,
+			  const struct ctl_context *ctx, size_t ctx_size)
+{
+	return NULL;
+}
+
 static inline struct ctl_table_header *
 __register_sysctl_fields(struct ctl_table_set *set, const char *path,
 			 const struct sysctl_field *fields, size_t field_count,
-- 
2.55.0

