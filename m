Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892456;
	b=s1T/qlp77YbQpY/K8+u2WVYPA2/SGSz4ARPv8XVhq7pIqQgdaexSYeNB6JJ849ExGuQI
	 mQJWS4hE/2skykxSGeAI6QDcZ+38WeC7cZV8CqRBRXUSCmuy9nrfr64WL9gZXOj1rsGS1
	 j9x7EEIMrQXXk9HiNQUq31WMIYcoORdFJUIc98ax7zSldG2tjz1BR3EZD4QX0c9D/KVgX
	 B+BDf95FgYsA1iAfE9mtWS7/JZdJ3Zppy67y47xGVHp56Bcva+slIRPbVkXI563cEeZLr
	 QJKYz1uoSL3YY1tD8WxMtRvRya3UT/P0pU7IbS8l26B1rcbHeC8FBZVTu+46v+kb5sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=pbsocLyCu9Rmc4dh+QFJRSGvOQb5wt/oaKgO1G9gF5g=;
	b=a2wnRf2vbO7SlUsCY1EBOTinrfuz/od5q/2BpiAlENP1bSwxYQ5Ete5Nr/8SdoHDuMzT
	 ncD/YyMbx3qcFdT8iL3IXl/xhtc1/OtjNvFq2IHbVJvjzjQWrEefvgHykFOcs8VHgBjXq
	 6IU3iVih2FB+geyQkPF8xkY+PRgOOH5tfu/7woxZfIjwImUPO6qZxz3afGuPMUghwTfA3
	 U33lq3dnAPOsDge+CRw5uTya8m1STJ8wBH5/kazTtF2HSsrEEceuLDSHXVTkrwpuPVssv
	 McWA//TKA1S2CEOq9bjQvMthsXsAnpp7556EbhWOfcWn4MRi+8fLxqN9qnHGPhxCSrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="KQK5LU/x";
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B826606A32C
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B826606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=KQK5LU/x
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53fdd2fb171so21195691cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892454; x=1794497254; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pbsocLyCu9Rmc4dh+QFJRSGvOQb5wt/oaKgO1G9gF5g=;
        b=KQK5LU/x+9RemIJlJmNJfQXWDClHpcCB4smF2/Z013ksgNIE2GSzRwQWL7t/PN3NCP
         JQBx5Tsm1WViOWMPWLoa71ExO5S9JECK0Xko1UCk8O3kluG5fD/5LTancgyxyMcMMHLG
         MgvbY/KGZpFbWbH6Lbb/Ya+6YhHK601aDSRX+QihB+c0w5WDPQ1ReKTflS55CYfERIyZ
         R0HIsfS3SeCPIdoYEdkEVjGC5yL0DD7g5SVNCTD2PDGqNK6g+XKRAarv7sJSLpgxTIkG
         YKNtA66ZoOgEIoXTbe5wXRCWgc2zg3KitJ/2RhCLMLFRg0tTswBkUCviG5eiMFUNTKeH
         JMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892454; x=1794497254;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pbsocLyCu9Rmc4dh+QFJRSGvOQb5wt/oaKgO1G9gF5g=;
        b=fRx/ERS/asq1FPdemtSnkkNjFz0VHcTI++jf7zU+pZCxPTW42Pc6I8xLvKBSgpZFHj
         fFCzWm7nlMvCwJfSbrQzUTT0tHnskwNwoEuoK2N85NNJgns01PjQFziBBC0VOy2hcBDN
         VfThExlP+d0rInbkhr/TlhgDpw2wDq/VbGDwOG14GAz8hZZb8+h4AxEP3HaYASEKBljb
         5GnPT0bdy8ddFbtVIdXaOBeiD0HsItR1RCfmb8kcJAnFOmEXC9AZ3KEPT3L3B4g4kZ3e
         fWcTwRTFbZDIrOM9wfUko9sBGHmVNRU0ujOg4lQXJKii3D27+ySm62KImxwowKz744Od
         gPcg==
X-Gm-Message-State: APuU4Z8COsfNNjS/XuiLOARRQFf6lQ29eU2AKwAD71nRxDIXIp+6MKjs
	Vl0a8foR0fQIVCE+f6mqNv6ZkVj1Kh5yGi5CK5aNEIbM3TVAK8OeAszAMGRbKUxS3qQ=
X-Gm-Gg: AYBFou300aMulZVaavuXZe3yOAYnSiuba4Lzy2RuxLe+cbvccrPkeLFtoU8/QE1pw5f
	VilsxpUtPGmfOtgxPbL4vw6ZSe+T0jMTQ8BX0veSjYt/k//JfLe1mtVNLnnzbdGDDX1i1nfS/N8
	GT5vFPj1bRVbeMFh0h5ysbAf5Aie8qOL+OHGoTRTyvzOiRyiDGB744zdhGWQtBpDlSTnYJF6Sz0
	Uc/NbYQMkgBeY98LV40c6Fra/rnkrY/G2tRfIuWv+vimLT/069gA4SE/U7uzqsL3N9PG86DRiKc
	gXyRsjgW7alCVQNyINbfk4ziteVWmIHXHOhXRm9ZSGK4rdjnOqMTVejtkMthDI5g36+m5GgM5My
	grNuyBiTVd/nCvjqDGnI1EvuWet71qNnP7y+YVf5Yck8e6gGqNxFGFUJfImertgQIQUCQW7U4KI
	kYRSZkI3Ei/D2pehv5z+RMEotOEelFDkXbuitXuH0y+kd7IEu1i3fsG2tRoRiGWrFNXxdrbBu3u
	TXHmKEY6eLabf+KGwex8ANykGrSmID7dZlg/rz1VEJJ9I7hALa0yg88IGUo1vCceZgOlzrL3g7N
	HIJcMa/hE4enWSTJptNXOiHExNUz6IKVdB8ygZZE0/G68KsvOY0ZJA2cMNHQGKTDbtA=
X-Received: by 2002:a05:622a:1f10:b0:537:59b4:3338 with SMTP id d75a77b69052e-542b65931a6mr335957311cf.25.1793892454290;
        Thu, 05 Nov 2026 07:27:34 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b100af507sm54208461cf.6.2026.11.05.07.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:27:33 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:03:06 +0000
Subject: [PATCH RFC v3 74/90] net: give a cell without a network no sockets
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
Message-Id: <20261105-b4-cells-v3-74-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890935; l=7967;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=27wHnLTXQNwpvpKsc5xrNHL8AKs/aDpCLvYXPRw6xys=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QN4edvDZLJ38j6ZZlJw8SqR/x4qkVV6HRcflJwWxhKmSLIhxpCrA54ubBo/fCXZqK+UetRMfRMd
 FGBZElve8fAc=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A cell whose "net" slot is left empty should have no network. So far it
has a network namespace that nobody has set up, which is not the same
thing. It is an empty network, and all the code that operates on one is
within reach. The tasks can create sockets of every family and talk to
rtnetlink and every other netlink family, although none of that is of any
use to them. There is no equivalent of failfs for the network.

Refuse every socket except a unix socket for a task of such a cell. The
error is EAFNOSUPPORT, which is what a kernel returns that was built
without the family. The check is in __sock_create(), which socket(),
socketpair() and the socket operation of io_uring all go through.

A socket that is handed to the cell works, and so do the sockets that
accept() returns for it. Holding the socket is the authority to use it,
and it is the only network that such a cell has.

Holding the socket is not the authority to inspect the network that it
belongs to, though. Many ioctls are about the network rather than the
socket, and they work on any socket. Through a single socket of the host,
a cell could list the devices of the host and their addresses. Refuse
those ioctls with ENODEV, by number, before anything else looks at them.
That covers every ioctl from SIOCADDRT upwards except SIOCOUTQNSD. The
protocol private range can contain either kind, so it is refused as well.

The check looks at the cell of the caller, not at a mark on the network
namespace. So it holds no matter which network namespace a socket belongs
to.

The decision is recorded once the seal has created the network namespace.
If the seal fails before that point, the slot can still be filled. If it
fails later and the builder then asks for the namespace with cell_open(),
the decision is reverted.

The network namespace still exists, because unix sockets need one. A
single static namespace for all such cells would avoid creating and
destroying a whole network namespace per cell. That requires moving the
unix socket tables out of struct net and is left for later. It would make
no difference from inside of the cell.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/cell.h   |  7 +++++++
 kernel/cell/boundary.c | 19 +++++++++++++++++++
 kernel/cell/internal.h |  1 +
 kernel/cell/slots.c    |  9 +++++++++
 net/socket.c           | 28 ++++++++++++++++++++++++++++
 5 files changed, 64 insertions(+)

diff --git a/include/linux/cell.h b/include/linux/cell.h
index 0451055f74fc..b12e2f124769 100644
--- a/include/linux/cell.h
+++ b/include/linux/cell.h
@@ -249,6 +249,13 @@ bool cell_may_change_cgroup(struct cgroup *cgrp);
 static inline bool cell_may_change_cgroup(struct cgroup *cgrp) { return true; }
 #endif
 
+/* A cell without a network. */
+#ifdef CONFIG_CELLS
+bool cell_no_net(void);
+#else
+static inline bool cell_no_net(void) { return false; }
+#endif
+
 /* A mount is idmapped for a cell. */
 #ifdef CONFIG_CELLS
 struct user_namespace *cell_idmap_userns(const struct file *file);
diff --git a/kernel/cell/boundary.c b/kernel/cell/boundary.c
index 3891dfe899f2..af67ef68d4a2 100644
--- a/kernel/cell/boundary.c
+++ b/kernel/cell/boundary.c
@@ -85,3 +85,22 @@ bool cell_may_change_cgroup(struct cgroup *cgrp)
 {
 	return cell_may_migrate(current, cgrp);
 }
+
+/**
+ * cell_no_net - is the caller in a cell that was built without a network?
+ *
+ * A cell whose "net" slot was left empty has no network. Its tasks make no
+ * socket but a unix socket, and learn nothing about a network through any socket.
+ * What they are handed works: a socket is the authority to use it.
+ *
+ * It goes by the cell of the caller and not by the network namespace it is in,
+ * so that it holds whatever that is.
+ *
+ * Return: true if so, false for a task of any other cell and of the host.
+ */
+bool cell_no_net(void)
+{
+	struct cell *cell = current_cell();
+
+	return cell && cell->no_net;
+}
diff --git a/kernel/cell/internal.h b/kernel/cell/internal.h
index c7a1895eadd4..4eafa19daa25 100644
--- a/kernel/cell/internal.h
+++ b/kernel/cell/internal.h
@@ -33,6 +33,7 @@ struct cell {
 	struct mnt_namespace	*mnt_ns;
 	struct pid_namespace	*pid_ns;
 	struct net		*net;
+	bool			no_net;		/* the slot was left empty */
 	struct cgroup		*budget;
 	u64			budget_id;
 	kuid_t			budget_uid;	/* who owned it before */
diff --git a/kernel/cell/slots.c b/kernel/cell/slots.c
index 75855f2ee020..2273d9ce733f 100644
--- a/kernel/cell/slots.c
+++ b/kernel/cell/slots.c
@@ -211,6 +211,7 @@ static int cell_seal(struct cell *cell)
 	struct nsproxy *nsproxy;
 	kuid_t root_uid;
 	kgid_t root_gid;
+	bool no_net;
 	int ret;
 
 	if (!cell->budget || !cell->mnt_ns)
@@ -227,9 +228,15 @@ static int cell_seal(struct cell *cell)
 	ret = cell_make_pid_ns(cell);
 	if (ret)
 		return ret;
+	/* No network, see cell_no_net(). Unix sockets need a namespace to live in all the same. */
+	no_net = !cell->net;
 	ret = cell_make_net(cell);
 	if (ret)
 		return ret;
+	/* Only now. Had that failed, the slot would still be there to be filled. */
+	if (no_net)
+		cell->no_net = true;
+
 	cgroup_ns = cgroup_cell_ns(cell->user_ns, cell->budget);
 	if (IS_ERR(cgroup_ns))
 		return PTR_ERR(cgroup_ns);
@@ -410,6 +417,8 @@ SYSCALL_DEFINE5(cell_open, int, cfd, unsigned int, what,
 			ret = cell_make_net(cell);
 			if (ret)
 				return ret;
+			/* A seal that failed may have made it. Whoever asks means to set it up. */
+			cell->no_net = false;
 			ns = &get_net(cell->net)->ns;
 		} else if (!strcmp(key, "pids")) {
 			ret = cell_make_pid_ns(cell);
diff --git a/net/socket.c b/net/socket.c
index 2e3b5737c481..c9659f7370ef 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -106,6 +106,7 @@
 #include <linux/route.h>
 #include <linux/termios.h>
 #include <linux/sockios.h>
+#include <linux/cell.h>
 #include <net/busy_poll.h>
 #include <linux/errqueue.h>
 #include <linux/ptp_clock_kernel.h>
@@ -1352,6 +1353,22 @@ static long sock_do_ioctl(struct net *net, struct socket *sock,
  *	what to do with it - that's up to the protocol still.
  */
 
+/*
+ * Is @cmd about the network that a socket is in, its devices, addresses and
+ * routes, and not about the socket? Those are served for any socket, whatever
+ * its family, some of them by the family itself. From SIOCADDRT up that is all
+ * of them but one. What a protocol keeps to itself, SIOCPROTOPRIVATE, may be
+ * either, the counters of multicast routing are in there, so it counts.
+ */
+static bool sock_ioctl_about_net(unsigned int cmd)
+{
+	if (cmd >= SIOCIWFIRST && cmd <= SIOCIWLAST)
+		return true;
+	if (!is_socket_ioctl_cmd(cmd) || _IOC_NR(cmd) < _IOC_NR(SIOCADDRT))
+		return false;
+	return cmd != SIOCOUTQNSD;
+}
+
 static long sock_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 {
 	const struct proto_ops  *ops;
@@ -1361,6 +1378,10 @@ static long sock_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	int pid, err;
 	struct net *net;
 
+	/* There is no network, so there are no devices. */
+	if (sock_ioctl_about_net(cmd) && cell_no_net())
+		return -ENODEV;
+
 	sock = file->private_data;
 	ops = READ_ONCE(sock->ops);
 	sk = sock->sk;
@@ -1620,6 +1641,10 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 	if (type < 0 || type >= SOCK_MAX)
 		return -EINVAL;
 
+	/* As in a kernel that was built without the rest of them. */
+	if (!kern && family != PF_UNIX && cell_no_net())
+		return -EAFNOSUPPORT;
+
 	/* Compatibility.
 
 	   This uglymoron is moved from INET layer to here to avoid
@@ -3642,6 +3667,9 @@ static long compat_sock_ioctl(struct file *file, unsigned int cmd,
 	struct sock *sk;
 	struct net *net;
 
+	if (sock_ioctl_about_net(cmd) && cell_no_net())
+		return -ENODEV;
+
 	sk = sock->sk;
 	net = sock_net(sk);
 

-- 
2.55.0

