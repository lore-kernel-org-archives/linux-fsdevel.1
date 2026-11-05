Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891764;
	b=liN6otaM/OI49Yj7mZsvBH4hjaYk3YJrcxlTdRx7cl6WaGwPdMBiybkdotlC/3eVPsz2
	 G3dksIm6b2Gr1wvIDvY7dKzGrueokVaUgmpo4JH+xBeNgn8Kg473/pNej+4KPo9wCd55R
	 HnReCcRYm54yaqF+BCwbU62S2FzKlSY76q0Vmq079ntXziUDk/lGcvpnQ6e/lAYWh+BnO
	 HTWgYj3i1obbQ1RcJgSWRJEpc14Fjf6dayljtJPvrAVkFg6ga6NdUuEGOwCL1oGQn6YLQ
	 klunJgzr1xnxFamyCN9Nn2eP9JAX/jMr3FAPfiOUf1fIs47MDEH80ksdu6pU36CwOdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891764;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=H4Mer0Lga1IOizNWXuhoug2hQz4DJn4K5PpD2JnRSys=;
	b=fREPTUyKOe5xjPJiUreU5PMGyH+8f7lDkUfYdjqpMpKqwj98JVMJcCZFVE+ox+tzAUdL
	 irg3rjffnhBlD7fy8ISvy/ixhDJBuVPnbb6xuYEwjxkiZh+lDZ9XCGiOJM6fFCGB1R0Ym
	 iPzUEOvId0wXhFQrpz6J3Gn1OaUyof73PErP69FgnjwzsxfcaaeSjS+2VaDcQ11X1jOpi
	 4zuKWAnuA/x8FufrkVV/rnMF8l3Y0s+zQVaVxC+8FbENkZAKwPju0jnMTdkIrePOCOTuD
	 fAK6gURArsTXwQCA06MZqHf5JjK8zDCPlaNi0jeHFsMCdf8kI43c9IJovNTOO4VpjFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=q0tMP3G5;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F82606A328
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95F82606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=q0tMP3G5
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f259cdc86so193691085a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891762; x=1794496562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H4Mer0Lga1IOizNWXuhoug2hQz4DJn4K5PpD2JnRSys=;
        b=q0tMP3G5TNwHLj0e92cF2/sGUzL0yaOkWUtG/jxiVXHh6qCvrroPpFtyNkrn2crsXE
         cx+0RrqC429hBqC8qKyYQs9ImXPCn9e/Gom2P16SBM8/PTmrbiNeYJkgcCVu9rNBytrQ
         EmKfgrJL2Fcnh86KAvc9pLN5D0RAWREwCiyU8QmahV5aeCHNCAElRKfIJOia+9L7UCb1
         6D5lUMiThI8NlU5z3x8f8+UrBNtNRJb1AzRNeJuxa+F7irdO2Mk7Jla3suaHWX1FJfF2
         gMCCO6LtiK8/iCzhC6Z4eHccr+9nGz7c1WOhn78NXn4GdW0W3N0JGjJnbZ9Ai1yIrm7X
         jhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891762; x=1794496562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H4Mer0Lga1IOizNWXuhoug2hQz4DJn4K5PpD2JnRSys=;
        b=YsNxOBiS10aNZ5F2d6Hh07mwQMfImFfHbjbVb6YUh4ZBctm5f4hUAPHjIu8006TOAe
         eSERnjSUQKDjDJ7IeE8kbuWsqjtqe5frjL/vrhIRuJiiBR6CagBTjDS5bA9u8OdvwV2V
         o8+XkrdoRmzeGXtRE25icGkljfeRAUIkZjFkcQ4rBEcMTaycQfpUGii4LzGFdjB7SbBV
         FhAklS5nTQuu+Upj+EqH8KCRVMIUGp5vCHA7L9vJ0i7Hlff5c6Aw/H+KFkDPe8pUoFWH
         ViP53D5Z7O4t8Z/AZKfbcrr5JBZiahUboAWtmvRnBEkzgUxJ+T5gaYrpxA/NWnIofJE8
         DN5g==
X-Gm-Message-State: APuU4Z9CKdpIvyjClnUwLsuGMMHE2Koldb5Hlc4oGg+Obj71gsm/81c6
	tKM9Cv5xZ5HaA/nf7JhRis4lRHM/Hf4AFyxZQNZblBdrF+lJ8DJ4B3G7J5cFZYSXh+I=
X-Gm-Gg: AYBFou1lRRrV5igTlSkxSPh1En34mHWkgZCBT1DJHEXY52XMIxGZPzGyoXgGWDB5JBD
	MV4bw/nP6jYM4XERLU+ccVfbFVgoUKqU4rjhshxDUt2nZ+PxCUjeyqNHM5ppBVpsLwxBqNFxjkE
	dQlvTzobrN4yj9aBvHOF1TEGDZiBapopJTI3syg6dRyMw4+Mp1WFmEX8aGONjwWIjYf+Hgn0qAn
	S3Mm/gsFbdjTTbmMWfBpgBcvoU7bPzcE7juxEDN9Eds0LERvnkbZHuUrMMMepRunc9dX4to/tA2
	LKzjggXw2jHd804N/zNo+kltJ0IipmWTnpvIT0z+2UjpmbOJQg306byIU0CnxO83iixIJI5q2UL
	YRRju0XNtf3ByYubJzYcleKlPF+xPCvhzcBTBCU/nqPk48IN359jaM8V3I08BNHynDMTvQLBnTP
	mq0HaaKMzlJjV8xYwcCxqCfgqQqag57j1YnuvnLglJ0xTEjkV7bLtdjX4L3D1cgExjPeLB44eNA
	58OqB5Ukg9qkYammdrmNHNVfpf7+fJSy6lHogUdfHPZnoo2MXViEjD+/HIR1CdRZyQLUTvwaK0e
	f0eRkc8/zsRcAQU9DSkEQHJPbetPbakgjupC54piQL4y2A==
X-Received: by 2002:a05:620a:1a08:b0:93c:9d56:a860 with SMTP id af79cd13be357-944217439e4mr3208698385a.19.1793891762448;
        Thu, 05 Nov 2026 07:16:02 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d468c574sm478328785a.6.2026.11.05.07.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:16:01 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:35 +0000
Subject: [PATCH RFC v3 43/90] pidfd: let pidfd_configure() set credentials
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
Message-Id: <20261105-b4-cells-v3-43-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890934; l=6052;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=xCOzpfBWllVdE4yMVFqvejvqNl2LulCdnNMFvhJsFR8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIDvwxZxncMYV40si2e99c3SO8+1/aH1vOhFmxmw64uRXS+2sj/KslaWVYs6FVtmRBEV6htKg8y
 WHl1V0Uc+WQ0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A task that is spawned into a cell starts as uid 0 of the cell. Add a way
to start it as another user. PIDFD_SET_BINARY with the key "cred" takes a
struct pidfd_cred that holds a uid, a gid and supplementary groups, all
given as ids of the cell.

The credentials are applied in the context of the new task. The task loses
its capabilities in the process, as it would with a setresuid() away from
uid 0.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/uapi/linux/pidfd.h |  10 ++++
 kernel/embryo.c            | 116 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)

diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index c01bce5e17ad..e1f6d27bb220 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -24,6 +24,16 @@ enum pidfd_configure_cmd {
 	PIDFD_SET_FD		= 2,	/* The file to have at number @key, from fd @aux */
 	PIDFD_CMD_START		= 3,	/* Make the task, apply everything and exec */
 };
+
+/* pidfd_configure(PIDFD_SET_BINARY, "cred"). Ids are those of the new task. */
+struct pidfd_cred {
+	__u32 uid;
+	__u32 gid;
+	__u32 ngroups;
+	__u32 __spare;
+	__aligned_u64 groups;	/* pointer to @ngroups __u32 gids */
+};
+
 /* Flags for pidfd_send_signal(). */
 #define PIDFD_SIGNAL_THREAD		(1UL << 0)
 #define PIDFD_SIGNAL_THREAD_GROUP	(1UL << 1)
diff --git a/kernel/embryo.c b/kernel/embryo.c
index 2c65a99eaeea..0ad85cd2b865 100644
--- a/kernel/embryo.c
+++ b/kernel/embryo.c
@@ -69,8 +69,14 @@ struct embryo {
 	struct embryo_fd	fds[EMBRYO_MAX_FDS];
 	unsigned int		nr_fds;
 
+	bool			have_cred;
+	kuid_t			uid;
+	kgid_t			gid;
+	struct group_info	*groups;
+
 	struct pid		*pid;		/* the reference alloc_pid_struct() returned */
 	struct cell		*cell;		/* where the task is going to be */
+	struct user_namespace	*user_ns;	/* likewise */
 
 	int			result;
 	struct completion	done;		/* embryo -> starter */
@@ -124,6 +130,9 @@ static void embryo_drop_config(struct embryo *e)
 	embryo_strings_free(&e->argv);
 	embryo_strings_free(&e->envp);
 	embryo_put_fds(e);
+	if (e->groups)
+		put_group_info(e->groups);
+	e->groups = NULL;
 }
 
 static void embryo_put(struct embryo *e)
@@ -132,6 +141,7 @@ static void embryo_put(struct embryo *e)
 		return;
 
 	embryo_drop_config(e);
+	put_user_ns(e->user_ns);
 	cell_put(e->cell);
 	kfree_rcu(e, rcu);
 }
@@ -143,6 +153,52 @@ static void embryo_detach(struct embryo *e)
 	embryo_put(e);
 }
 
+static int embryo_apply_cred(struct embryo *e)
+{
+	const struct cred *old = current_cred();
+	struct user_struct *user;
+	struct cred *new;
+	int ret;
+
+	if (!e->have_cred)
+		return 0;
+
+	new = prepare_creds();
+	if (!new)
+		return -ENOMEM;
+
+	new->uid = new->euid = new->suid = new->fsuid = e->uid;
+	new->gid = new->egid = new->sgid = new->fsgid = e->gid;
+	if (e->groups)
+		set_groups(new, e->groups);
+
+	ret = -EAGAIN;
+	user = alloc_uid(e->uid);
+	if (!user)
+		goto err;
+	free_uid(new->user);
+	new->user = user;
+
+	/* Leaving uid 0 behind costs the capabilities, as setresuid() would. */
+	ret = security_task_fix_setuid(new, old, LSM_SETID_RES);
+	if (ret)
+		goto err;
+	ret = security_task_fix_setgid(new, old, LSM_SETID_RES);
+	if (ret)
+		goto err;
+	ret = security_task_fix_setgroups(new, old);
+	if (ret)
+		goto err;
+	ret = set_cred_ucounts(new);
+	if (ret)
+		goto err;
+	return commit_creds(new);
+
+err:
+	abort_creds(new);
+	return ret;
+}
+
 static int embryo_exec(struct embryo *e)
 {
 	static const char * const no_strings[] = { NULL };
@@ -150,6 +206,9 @@ static int embryo_exec(struct embryo *e)
 	int ret;
 
 	ret = embryo_install_fds(e);
+	if (ret)
+		return ret;
+	ret = embryo_apply_cred(e);
 	if (ret)
 		return ret;
 
@@ -286,6 +345,7 @@ int embryo_pidfd_open(int cfd, unsigned int flags)
 	}
 	e->pid = alloc_pid_struct(cell_nsproxy(cell)->pid_ns_for_children);
 	e->cell = cell_get(cell);
+	e->user_ns = get_user_ns(cell_user_ns(cell));
 	cell_fork_finish(cell);
 
 	ret = -ENOMEM;
@@ -389,6 +449,60 @@ static int embryo_set_strings(struct embryo_strings *s, const void __user *ubloc
 	return 0;
 }
 
+static int embryo_set_cred(struct embryo *e, const void __user *uvalue, size_t len)
+{
+	struct group_info *groups = NULL;
+	struct pidfd_cred tc;
+	kuid_t uid;
+	kgid_t gid;
+	u32 i;
+
+	if (len != sizeof(tc))
+		return -EINVAL;
+	if (copy_from_user(&tc, uvalue, sizeof(tc)))
+		return -EFAULT;
+	if (tc.__spare || tc.ngroups > NGROUPS_MAX)
+		return -EINVAL;
+
+	/* The ids are the cell's own. One it does not have cannot be named. */
+	uid = make_kuid(e->user_ns, tc.uid);
+	gid = make_kgid(e->user_ns, tc.gid);
+	if (!uid_valid(uid) || !gid_valid(gid))
+		return -EINVAL;
+
+	if (tc.ngroups) {
+		const u32 __user *ugroups = u64_to_user_ptr(tc.groups);
+
+		if (!userns_may_setgroups(e->user_ns))
+			return -EPERM;
+		groups = groups_alloc(tc.ngroups);
+		if (!groups)
+			return -ENOMEM;
+		for (i = 0; i < tc.ngroups; i++) {
+			u32 g;
+
+			if (get_user(g, ugroups + i)) {
+				put_group_info(groups);
+				return -EFAULT;
+			}
+			groups->gid[i] = make_kgid(e->user_ns, g);
+			if (!gid_valid(groups->gid[i])) {
+				put_group_info(groups);
+				return -EINVAL;
+			}
+		}
+		groups_sort(groups);
+	}
+
+	if (e->groups)
+		put_group_info(e->groups);
+	e->groups = groups;
+	e->uid = uid;
+	e->gid = gid;
+	e->have_cred = true;
+	return 0;
+}
+
 /*
  * The file table of the new task is exactly what is put here. After this
  * nothing crosses the boundary of the cell any more, so this is where it is
@@ -576,6 +690,8 @@ SYSCALL_DEFINE5(pidfd_configure, int, pidfd, unsigned int, cmd,
 			ret = embryo_set_strings(&e->argv, uvalue, aux);
 		else if (!strcmp(key, "envp"))
 			ret = embryo_set_strings(&e->envp, uvalue, aux);
+		else if (!strcmp(key, "cred"))
+			ret = embryo_set_cred(e, uvalue, aux);
 		else
 			ret = -EINVAL;
 		break;

-- 
2.55.0

