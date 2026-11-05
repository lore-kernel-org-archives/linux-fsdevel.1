Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891720;
	b=v5QdCvFWtiEZETMjifXZAYgo6qFkKn909p2h7gDAxSNddIvtx3OGqZkdbSeumCUG52CX
	 1K0SlcI0q/drr2ViTGuzD/FZmxzfmTlWjzzpxWp7R7LAiZQWL56BkKgwb0N1PTr7w7z9Q
	 ezDNOuxfNUIf/3ANHl4Xji8/91XW1NZtVGx2RSgAy4z8UVesLxPzzo4yLo5b/AE4oGxOo
	 rQgYjffUO5ZBjwIQmDN2IeLpZzutHu1sf4arSLxWxUKRKkH9J7GRy4Z2NxTDb5G+n+suU
	 7vUobxPy/lCVGEAnHJQOvL9mZgzBLgn0XN/mKOHEdy/tRpcHkGhfH26F5FDpLPjdeyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=+ba4ngiwOmk7U6+AfgvildQAKlCMw5eTHupi4GkOkgA=;
	b=wzRT4aerK0nB2JFUypyNxSK0J062a7UGf5ETG8PPShD0eIX74JlMGrorJpmGIIsmNXvf
	 oEhtHLmafj7ssQGLQyBeurMGDjA0t4rgy1QF36ICb8j7IsrQyaB154itGKQX2ykOA8W/a
	 cbvhu/gcTJskREC3Rcr2x6L4vAQzmjoR80EvuWZmyM/etRGEd3spXgAl5vU/+RQwSISw8
	 p5p+M8wRY7ZohaDu2Lb9sr/L9M7WDsXvQpyBQhBG8GsW2ml0MDbjm9wXp+FTStwDjspfx
	 PX0ocLOsbYWw3GAOR7y7SOtDQLn1QGByXblQ12PSAl5xLvJu2bzq2J6MHu+gy96fHeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=lmXeANSs;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11545606A326
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11545606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=lmXeANSs
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5364d86f7f0so22850281cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891719; x=1794496519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ba4ngiwOmk7U6+AfgvildQAKlCMw5eTHupi4GkOkgA=;
        b=lmXeANSsfuf6hQQEc5EOt41HSw3VWd3auXsuEdizoYTZbDLT1YyrFL7mxVN1g8wA/K
         C3CyaHO0DHjz6gDV/dy/hxICpB0k3xWLUlMIDFcuU22wqXfgY9viPSl1AR8If3FZf7yK
         zyH6cyX6eGLLDdNBC7AH05C5PEIfKZUYLrVCeP8PvXoGET7urV9QOAjtVSYbpDx7SlmB
         ECxttbBN/u/G/AMqN24hMiIQ5IFffC+ZXUL4JX2v4IFgm38gGgRrmQL4/IW5ZR8+1Vea
         w7U8c8BEZb7vJeuIdPT86XjcbDZ6+RqVwIlPag4dJNC2oHB+2tQlQx9nuM68s57umwIC
         kY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891719; x=1794496519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ba4ngiwOmk7U6+AfgvildQAKlCMw5eTHupi4GkOkgA=;
        b=mKzrdoEjPQQScWlWlvV13CEV+Nd4LLwIsALjGyR9CAbu1qV1MBzI6bJ9+YGt3a3ECq
         aXUIe7b3esfyCXqLc+vd2g2IBDbOpROo1UOe5XBvJ73vWqUdUGvLlvl9znn5Dja6pFre
         udHoFn/mIi9zErGyC4tr58MP0vVONehAwxrdXsaE7GY953QEKf4LhGxtFU1HBTZCEIVe
         0STRRmcLN3wTec3dZ4iDi/ZU4yjdwImdeF5HhUJRsOETJb4VxMSWcYb+9ogsI4969S0U
         9D4tpsDwuRqOUVGaDCU1w5KrEVCRna0q8EBmPRbd8/VK+iqtwkOYs1jmDqDvfrJZ1A86
         5ZVQ==
X-Gm-Message-State: APuU4Z9uB8/35pvboNL5sJBLVm7K7HcL54DQ7/rl9H+JrZ0m924IDx2I
	WnxiZGsBXESUw7mUS+fkGlnylV6ywmbKrGr94e+At2eB0byrGa2RF7chylBgwelG0yc=
X-Gm-Gg: AYBFou1QztwjtHKlY+4xkcF06s0lSldyW51zJXqn4eQYKxrLNXrX8Wk6wUudCE6cFet
	76sHLJQAw67slRcSYxSXCjLIkdF2BtzU5WVPyMzX50/3+CkezmBprurRGWM2HRKTpKj68SeCwDW
	pkwkdadWOVs7ERyB4/ZHlfu/v2WfcnN5L4E6nWPCdmLTA7vTbwKLDQYopR/OoHybvs5+q4VaMW4
	6bAbRpOn1p3AsJzC7NLSjBK43jW6/jq01HHAmVavt/CBfHjJUqsCta/2ggrFmCPQ0x5hlrAzpv/
	qGWtA5sjEEArpfAAMR2qORjsIcJhOA8wKsRHsQARvs1QQWeZIw9wPA9thDQqKAQhLEVVgSh/moz
	nPTRG1DgWxZ3TBrs6H5fYEpwaojCYYCglhQjXc4aTfIMZv3faHG9lvrym+yjYsDOXzBPlgAXoiQ
	tfxpj5NluAKyfqzE7rkDf1SiVqPkSSPrFlNgUOJ42hZSM1uiNKUNLhJK0/GRZThGrXgMUpX3xXp
	4vHPQ+N7lMz7vPWDKs22VzjuFN5ICElwti7LCIxiwb7cbvSSfvqgTrW9k4TYbOUlYwtnoVudClB
	odgwUr6EKVcfAxc6PgdY/w5t+HQsXwv3pyRVU+yqVdva5fhUm+raD7VVA+j+7yKmC+s=
X-Received: by 2002:a05:622a:5818:b0:533:9753:4e03 with SMTP id d75a77b69052e-542b059a7c6mr313925631cf.0.1793891718792;
        Thu, 05 Nov 2026 07:15:18 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e0139ccsm49958546d6.28.2026.11.05.07.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:15:17 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:33 +0000
Subject: [PATCH RFC v3 41/90] pidfd: add pidfd_configure()
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-cells-v3-41-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890933; l=10236;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=D/qy6sHPV4k/RfQ6dFvWotMOpbgLiaRV7feEgFhMmQ8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QO2nhf81BBqbWNCKoDYZG/mft7XR0KBspDN+oiQ6wwjqyeq0i1STTUTPk3HgZ9DCYVlY1b2MHKm
 plo7JHgIRXgE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Add the system call that describes the task of an empty pidfd and starts
it. It is modelled on fsconfig(): it takes a command, a key and a value,
and data only flows into the kernel.

    pidfd = pidfd_open(cellfd, PIDFD_EMPTY);
    pidfd_configure(pidfd, PIDFD_SET_STRING, "exec", "/sbin/init", 0);
    pidfd_configure(pidfd, PIDFD_SET_BINARY, "argv", "init\0-v", 8);
    pidfd_configure(pidfd, PIDFD_CMD_START, NULL, NULL, 0);

This patch adds the keys "exec", "argv" and "envp", and PIDFD_CMD_START.
The start command creates the task, applies the configuration in the
context of the task, lets it exec, and waits for the exec to finish. If
anything fails, PIDFD_CMD_START returns the error, and the task is killed
if it already exists. A pidfd can only be started once.

The task gets default signal dispositions and its own session.
CLONE_CLEAR_SIGHAND would keep signals ignored that the caller ignores, so
the handlers are flushed the way they are for a usermode helper. Nobody
has to wait for the task. It is reaped automatically, and the pidfd
reports how it exited.

The pidfd may be kept open for a long time after the start, so the
configuration is freed as soon as it has been used.

The LSM hooks for exec run in the context of the new task, as for any
exec. Seccomp filters apply to the system calls of the new program. But
the work that the start command does is not a system call of the new task,
so the filters are not consulted for it. A filter that denies execve() to
stop a task from running another program must also deny pidfd_configure(),
just as such filters once had to learn about execveat().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/uapi/linux/pidfd.h |   7 ++
 kernel/embryo.c            | 258 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 265 insertions(+)

diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index eb3704687c04..c01bce5e17ad 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -17,6 +17,13 @@
 #define PIDFD_AUTOKILL O_TRUNC
 #endif
 
+/* pidfd_configure(): @cmd. Data only ever goes in. */
+enum pidfd_configure_cmd {
+	PIDFD_SET_STRING	= 0,	/* Set @key to the string in @value */
+	PIDFD_SET_BINARY	= 1,	/* Set @key to the @aux bytes at @value */
+	PIDFD_SET_FD		= 2,	/* The file to have at number @key, from fd @aux */
+	PIDFD_CMD_START		= 3,	/* Make the task, apply everything and exec */
+};
 /* Flags for pidfd_send_signal(). */
 #define PIDFD_SIGNAL_THREAD		(1UL << 0)
 #define PIDFD_SIGNAL_THREAD_GROUP	(1UL << 1)
diff --git a/kernel/embryo.c b/kernel/embryo.c
index e052c09f9192..f405efb195c7 100644
--- a/kernel/embryo.c
+++ b/kernel/embryo.c
@@ -40,6 +40,10 @@
 #include <net/af_unix.h>
 #include <uapi/linux/pidfd.h>
 
+#define EMBRYO_KEY_MAX		32
+#define EMBRYO_MAX_STRINGS	4096
+#define EMBRYO_MAX_BLOCK	(256 * 1024)
+
 struct embryo_strings {
 	char		*block;		/* NUL terminated strings, back to back */
 	const char	**vec;		/* NULL terminated, points into @block */
@@ -94,6 +98,53 @@ static void embryo_put(struct embryo *e)
 	kfree_rcu(e, rcu);
 }
 
+/* The task is done being an embryo, one way or the other. */
+static void embryo_detach(struct embryo *e)
+{
+	WRITE_ONCE(current->embryo, NULL);
+	embryo_put(e);
+}
+
+static int embryo_exec(struct embryo *e)
+{
+	static const char * const no_strings[] = { NULL };
+	const char *argv0[] = { e->exec, NULL };
+
+	return kernel_execve(e->exec, e->argv.vec ?: argv0,
+			     e->envp.vec ?: no_strings);
+}
+
+static int embryo_main(void *arg)
+{
+	struct embryo *e = arg;
+	int ret;
+
+	/* CLONE_CLEAR_SIGHAND leaves what the starter ignores ignored. */
+	flush_signal_handlers(current, 1);
+
+	/* The starter's session, process group and terminal are not ours. */
+	ksys_setsid();
+	set_personality(PER_LINUX);
+
+	/* @started is set, so nobody changes anything any more. */
+	ret = embryo_exec(e);
+	embryo_drop_config(e);
+	/*
+	 * A signal to the embryo is no signal to whoever started it. Whatever
+	 * interrupted the exec, the embryo is about to be killed.
+	 */
+	if (ret && (fatal_signal_pending(current) || ret <= -ERESTARTSYS))
+		ret = -ESRCH;
+	e->result = ret;
+	complete_all(&e->done);
+	embryo_detach(e);
+	if (ret)
+		do_group_exit(SIGKILL);
+
+	/* Off to user mode. */
+	return 0;
+}
+
 /**
  * embryo_fork_finish - done creating an embryo, one way or the other
  * @args: the arguments of the clone, with @args->embryo set
@@ -242,3 +293,210 @@ void embryo_pidfd_release(struct file *file)
 		free_pid_struct(e->pid);
 	embryo_put(e);
 }
+
+static struct embryo *embryo_from_file(struct file *file)
+{
+	struct pid *pid;
+
+	pid = pidfd_pid(file);
+	if (IS_ERR(pid))
+		return ERR_CAST(pid);
+	/* Only the file pidfd_open() returned will do. Nothing else ever has this. */
+	if (!(file->f_flags & PIDFD_EMPTY))
+		return ERR_PTR(-EPERM);
+	return file->private_data;
+}
+
+static int embryo_set_strings(struct embryo_strings *s, const void __user *ublock,
+			      size_t len)
+{
+	struct embryo_strings new = {};
+	unsigned int nr = 0, i;
+	size_t off;
+
+	if (!len || len > EMBRYO_MAX_BLOCK)
+		return -E2BIG;
+
+	new.block = vmemdup_user(ublock, len);
+	if (IS_ERR(new.block))
+		return PTR_ERR(new.block);
+	if (new.block[len - 1]) {
+		kvfree(new.block);
+		return -EINVAL;
+	}
+
+	for (off = 0; off < len; off += strlen(new.block + off) + 1)
+		nr++;
+	if (nr > EMBRYO_MAX_STRINGS) {
+		kvfree(new.block);
+		return -E2BIG;
+	}
+
+	new.vec = kvmalloc_array(nr + 1, sizeof(*new.vec), GFP_KERNEL_ACCOUNT);
+	if (!new.vec) {
+		kvfree(new.block);
+		return -ENOMEM;
+	}
+	for (off = 0, i = 0; off < len; off += strlen(new.block + off) + 1)
+		new.vec[i++] = new.block + off;
+	new.vec[i] = NULL;
+
+	embryo_strings_free(s);
+	*s = new;
+	return 0;
+}
+
+static int embryo_start(struct embryo *e)
+{
+	struct kernel_clone_args args = {
+		/*
+		 * CLONE_VM only says "do not copy the mm": there is none,
+		 * copy_mm() sees to that. Nobody has to wait for the task, the
+		 * pidfd tells. The rest is what every task of a cell gets.
+		 */
+		.flags		= CLONE_VM | CLONE_UNTRACED | CLONE_AUTOREAP |
+				  CLONE_INTO_CGROUP | CLONE_NNP | CLONE_CLEAR_SIGHAND,
+		.fn		= embryo_main,
+		.fn_arg		= e,
+		.name		= "embryo",
+		.pid		= e->pid,
+		.cell		= e->cell,
+		.embryo		= e,
+	};
+	pid_t nr;
+	int ret;
+
+	/* Until embryo_fork_finish(). */
+	ret = cell_fork_prepare(e->cell);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &e->lock) {
+		ret = e->started ? -EBUSY : e->exec ? 0 : -EINVAL;
+		if (!ret)
+			e->started = true;
+	}
+	if (ret) {
+		cell_fork_finish(e->cell);
+		return ret;
+	}
+
+	/* For the task. */
+	refcount_inc(&e->ref);
+	nr = kernel_clone(&args);
+	/*
+	 * A signal is pending for the caller, so the fork is to be started over
+	 * once that has been seen to, as any fork is. It has not been tried.
+	 */
+	if (nr == -ERESTARTNOINTR) {
+		scoped_guard(mutex, &e->lock)
+			e->started = false;
+		return nr;
+	}
+	if (nr < 0) {
+		scoped_guard(mutex, &e->lock)
+			embryo_drop_config(e);
+		return nr;
+	}
+
+	/*
+	 * Everything up to the point of no return of the exec is reported
+	 * here. Past that it is a fatal signal, for the pidfd to tell.
+	 */
+	if (wait_for_completion_killable(&e->done))
+		return -EINTR;
+	return e->result;
+}
+
+/**
+ * sys_pidfd_configure - say what the task of an empty pidfd is to be, and start it
+ * @pidfd:  what pidfd_open() returned for PIDFD_EMPTY, and no other pidfd
+ * @cmd:    one of enum pidfd_configure_cmd
+ * @ukey:   the name of what is set, or NULL for PIDFD_CMD_START
+ * @uvalue: a string for PIDFD_SET_STRING, @aux bytes for PIDFD_SET_BINARY
+ * @aux:    a length for PIDFD_SET_BINARY, a file descriptor for PIDFD_SET_FD
+ *
+ * Shaped like fsconfig(). Data only goes in.
+ *
+ * PIDFD_CMD_START makes the task, applies everything in its context, has it exec
+ * and waits for that. Whatever goes wrong is returned here, and the task, if it
+ * got that far, is killed. It can be tried only once. Being started over because
+ * a signal is pending for the caller, as a fork is, does not count.
+ *
+ * Return: 0, -EPERM for any other pidfd, -EBUSY once it was started, -ESRCH if
+ * the task or the cell was killed, -EOPNOTSUPP for an unknown @cmd, -EINVAL for
+ * an unknown key or arguments that do not go with @cmd, or what went wrong.
+ */
+SYSCALL_DEFINE5(pidfd_configure, int, pidfd, unsigned int, cmd,
+		const char __user *, ukey, const void __user *, uvalue, int, aux)
+{
+	char *key __free(kfree) = NULL;
+	char *str __free(kfree) = NULL;
+	struct embryo *e;
+	int ret;
+
+	switch (cmd) {
+	case PIDFD_SET_STRING:
+		if (!ukey || !uvalue || aux)
+			return -EINVAL;
+		break;
+	case PIDFD_SET_BINARY:
+		if (!ukey || !uvalue || aux <= 0)
+			return -EINVAL;
+		break;
+	case PIDFD_CMD_START:
+		if (ukey || uvalue || aux)
+			return -EINVAL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (ukey) {
+		key = strndup_user(ukey, EMBRYO_KEY_MAX);
+		if (IS_ERR(key))
+			return PTR_ERR(no_free_ptr(key));
+	}
+	if (cmd == PIDFD_SET_STRING) {
+		str = strndup_user(uvalue, PATH_MAX);
+		if (IS_ERR(str))
+			return PTR_ERR(no_free_ptr(str));
+	}
+
+	CLASS(fd, f)(pidfd);
+	if (fd_empty(f))
+		return -EBADF;
+	e = embryo_from_file(fd_file(f));
+	if (IS_ERR(e))
+		return PTR_ERR(e);
+
+	if (cmd == PIDFD_CMD_START)
+		return embryo_start(e);
+
+	mutex_lock(&e->lock);
+	ret = -EBUSY;
+	if (e->started)
+		goto out;
+
+	switch (cmd) {
+	case PIDFD_SET_STRING:
+		ret = -EINVAL;
+		if (strcmp(key, "exec"))
+			break;
+		kfree(e->exec);
+		e->exec = no_free_ptr(str);
+		ret = 0;
+		break;
+	case PIDFD_SET_BINARY:
+		if (!strcmp(key, "argv"))
+			ret = embryo_set_strings(&e->argv, uvalue, aux);
+		else if (!strcmp(key, "envp"))
+			ret = embryo_set_strings(&e->envp, uvalue, aux);
+		else
+			ret = -EINVAL;
+		break;
+	}
+out:
+	mutex_unlock(&e->lock);
+	return ret;
+}

-- 
2.55.0

