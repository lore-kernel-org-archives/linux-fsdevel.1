Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892477;
	b=lQ/5jK59eIRDyF+fwBCY0tN9Rs41EYiIma9tT8HjvDY63/A1heQOiHsv07XJ3tb71TSG
	 +NZevw/F2vQdiMVwR9aeTFgfs2UHpb2ShMjF/mYLMIylmdnrOPlMymWJHblzstef6wAl1
	 Z4gg2JAK+Onox0V4Dy9S/7OCuQixJT47MVJk7mTH3twRyZ11OPZKT/r4BI4Adaduc+3hL
	 Hu5UcD3/HfKGu9jLW75jgKnMxfJr4gC3FqxrpAvj/tM5EPU/WGyV9Pdu5ENFXzaOqaqH2
	 PDtDEywhw33x9k+mY3BCtQo2WMt5GMMCUoVbqopuIYgOyuNbSftAd43NIsUmMG3SOvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=s0+tjbQjpmmQyRSNOkK8YN5U0O+gpu5YFl5evGoFkBs=;
	b=orsH/U3AoTjnax9wsyK2GHquOGueSQxsprOi3/wR/etMRHaHuDwy7SuuJfyTGhn9+M9f
	 Fz1kt5JWIiYTHIdkQC25EjtgDPu+GB45yl/6Wlaujz8TaGrQOj4h/kl6hzWUKP3V4mVy2
	 dQpVtRZDlNGf9XcI13kD+1YMmNFapsCl7iw31OsOQoIgdmGw8Bi81UAEugp4BFfCZ+U1c
	 GtpqW/eaSIuy84VQD0dtvoUFhS9MeyQRiSVhNd2TtUB4PTswLK9Gpoz92r2QqgZtNfZ7B
	 vRZdAEXReL5CqhVtlMtY92nDPZ3wjU3XIaM+E6Ybp101H4gxxdwbgqNu9ZiVsqBCHAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=doX9cM1L;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC93E606A326
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC93E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=doX9cM1L
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-54d9ac78f2eso2983081cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892476; x=1794497276; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s0+tjbQjpmmQyRSNOkK8YN5U0O+gpu5YFl5evGoFkBs=;
        b=doX9cM1LKJkNFNewyMmGbFfHvqk4Td/BFypCpvwrjU5C/xLqUt7B4F6l9hpKuq3XF+
         aH+3n9pfXJtuTIwJlsoOzzmwsIXrRL1GzVHF5xU6KHQvRjklo+9CQZohiTvUPUUaNKFO
         0cHQ7XdHQoFSngAusvlRQAXmABoaApZQJizgJKIr9f5Fb31uSwjoYMbgx28X920uN/8O
         SlB6UNZeXw1zW2qAHTyI7P8X57lLC6R4T+m7Tc0HTKUCR7uGyAWWPUVbuQzmpBF8B1vd
         lGOwtOMbq+h2qZ/UtEu5ZRboioAUGQmwI1qSICLhbYiCaR9mFR4RMpM8rCCni9kGtW72
         cglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892476; x=1794497276;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s0+tjbQjpmmQyRSNOkK8YN5U0O+gpu5YFl5evGoFkBs=;
        b=samSgcFx+8PceYXNBbb+sn9rAmUUTzKXsWKcRKzJ5QTdaErKQK5P+SnnhG0OKo4aUG
         TNrJ7tuMj9FTdiuPOR6GWJmLDnsD3dkTOnLoxFWdaHIMCmZIPZZyCw/3qLjlb4wtiyOo
         qscCWvv42YuekI3xtC37xdBj3A7qCV7PABggj7tLtn9DVdXbsp7nNJTaUJBRbP5clbnq
         j8ds1i2XWhz8rl4whKymJzg/KJIxAduJaCGwPpF7fd2jHGgMs1cq+iF4bC7AeP35i3Gt
         l+rEDi4J+jXjOI0WU8vIYyjwDlm2TOQU6iATHKeZnv0DLZ6Fz3OdPMAU8HLM18bI++vU
         8HLQ==
X-Gm-Message-State: APuU4Z9wZB7NCyURFcvJSblLcs4QdyvgtU6+yhWYBBWHXZTH6IFkRvcs
	nul6oGMlesmQ+ntxMwnKPujgIFch39VA1JJ5IgSwwFMIo7VCIGPD08zBi52WcQnbggY=
X-Gm-Gg: AYBFou2Tjpu3kq5d6boYNcBsMjXdtoosJrXDDPA2Nbt+S1o0cap1yjNgjPFXRXsHr0z
	LL6KKcvRsuY9NKqCdzyrBH+hgjLvwxhkzWTjvri9rPYzY8u/BOGDMuBRc/V71Zz3PGRA0q/HkoM
	LZ7xsGfbG7kNCv/dadj9BpzlbSVy/n7rAOmF2XbroLf84IixDxThDhMBw3qcdZvIBLcSRhm7Atd
	gGyrAAebZ/cAgNq+nurPeZYbYgjmBRaENbMmyTm9QaVwDIygTisUsZzFEB5kpddF7+ZSo8tOxL2
	68ia4r5Lb30ONySRfV/BefncqVNG9xvmkfou7EL76cU4PQaXqOJV3kHu1MF3EliRENl4hXBs+Vk
	jBxI+JvXgj9I5PiWCmSRnnReOAP4UP6ecffs7rRTP/gcwnFQ68/oBqoQzq5zyO7v13Guu+bn6I1
	YwYDFMZ+0348hQPdwakZfpa6fnQBHf2UzZDNFGsBEpP2su1BzUSKyiYrEGaIefzetlM/VttyLdm
	m2rB4nw2WNylAIUMzaB8/GI0SdPY0KsvJEpP8BNMOMiBM76lBKrMDM8RUpKpwWEN75mwfXF7Xw/
	W812YTD/8VEK1j0t8kt5KXV+/Nki3daGhoeO+pmUUt5WwQ==
X-Received: by 2002:a05:622a:c01:b0:535:19f5:e9da with SMTP id d75a77b69052e-542b7044dbbmr317145391cf.30.1793892475438;
        Thu, 05 Nov 2026 07:27:55 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b100af507sm54216541cf.6.2026.11.05.07.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:27:54 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:03:07 +0000
Subject: [PATCH RFC v3 75/90] net: add net_may()
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
Message-Id: <20261105-b4-cells-v3-75-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890936; l=9134;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=ImuQr/of0tvY4+1OFi9Fedu9tLM7V/PhbuNfkIPksV0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGhESbgqYDCfHJGYY8iCxY26KcV3+K5eN1r1WbSgdQxWS+4KDa2KBhd+78vfv4FrXIT75L6u2eA
 v/gzXJkMoXgo=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Almost every operation that changes a network namespace is guarded by the
same check: ns_capable(net->user_ns, CAP_NET_ADMIN). There are well over a
hundred of these checks. They cover devices, addresses, routes, netfilter,
traffic control, tunnels, IPsec, socket options and more.

The check does not say which of these it is guarding. So there is no way
to allow one kind of operation without allowing all of them. A program
that only needs to add a netfilter rule must be given the power to create
tunnels as well.

Add net_may(net, right). It asks whether the caller may do one particular
kind of thing to a network namespace, and enum net_right names the kinds.
For now the answer is the same as before: NET_RIGHT_RAW requires
CAP_NET_RAW over the owner of the namespace, and every other right
requires CAP_NET_ADMIN. A single function, net_right_ns(), makes that
decision, so a later patch can change it in one place.

Add a variant for each form the existing checks take:

  net_may_noaudit()   like ns_capable_noaudit()
  file_net_may()      like file_ns_capable(), for the opener of a file
  sockopt_net_may()   like sockopt_ns_capable(), which lets BPF set options
  netlink_net_may()   like netlink_ns_capable(), which checks both the
                      opener of the socket and the sender of the message

The rights follow the entry points, because most of the code in question
sits behind a handful of them. A right can be split later if its entry
point learns to distinguish more cases.

There are no users yet.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/netlink.h     |  2 ++
 include/net/net_namespace.h | 25 +++++++++++++++++++
 include/net/sock.h          |  1 +
 net/core/net_namespace.c    | 58 +++++++++++++++++++++++++++++++++++++++++++++
 net/core/sock.c             | 13 ++++++++++
 net/netlink/af_netlink.c    | 21 ++++++++++++++++
 6 files changed, 120 insertions(+)

diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index 882e9c1b6c1d..16ecb55e9f12 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -10,6 +10,7 @@
 #include <uapi/linux/netlink.h>
 
 struct net;
+enum net_right;
 
 void do_trace_netlink_extack(const char *msg);
 
@@ -356,6 +357,7 @@ bool netlink_ns_capable(const struct sk_buff *skb,
 			struct user_namespace *ns, int cap);
 bool netlink_capable(const struct sk_buff *skb, int cap);
 bool netlink_net_capable(const struct sk_buff *skb, int cap);
+bool netlink_net_may(const struct sk_buff *skb, const struct net *net, enum net_right right);
 struct sk_buff *netlink_alloc_large_skb(unsigned int size, int broadcast);
 
 #endif	/* __LINUX_NETLINK_H */
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index c29a22ca178f..badee0bbc567 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -459,6 +459,31 @@ static inline struct net *read_pnet_rcu(const possible_net_t *pnet)
 #define __net_initconst	__initconst
 #endif
 
+/**
+ * enum net_right - what somebody wants to do to a network namespace
+ *
+ * Changing anything about a network namespace takes a capability over the user
+ * namespace that owns it, and nearly always that is CAP_NET_ADMIN, whatever it is
+ * that is to be changed. A check that goes by way of net_may() says what it is for.
+ */
+enum net_right {
+	NET_RIGHT_LINK,		/* change a device: up, down, mtu, name */
+	NET_RIGHT_LINK_NEW,	/* make and remove devices */
+	NET_RIGHT_ADDR,		/* addresses */
+	NET_RIGHT_ROUTE,	/* routes, rules, neighbours */
+	NET_RIGHT_FILTER,	/* netfilter */
+	NET_RIGHT_TC,		/* queueing disciplines, classes, filters */
+	NET_RIGHT_TUN,		/* make tun and tap devices */
+	NET_RIGHT_SYSCTL,	/* /proc/sys/net */
+	NET_RIGHT_SOCKOPT,	/* socket options that reach beyond the socket */
+	NET_RIGHT_RAW,		/* raw and packet sockets. This one is CAP_NET_RAW */
+	NET_RIGHT_NR
+};
+
+bool net_may(const struct net *net, enum net_right right);
+bool net_may_noaudit(const struct net *net, enum net_right right);
+bool file_net_may(const struct file *file, const struct net *net, enum net_right right);
+
 int peernet2id_alloc(struct net *net, struct net *peer, gfp_t gfp);
 int peernet2id(const struct net *net, struct net *peer);
 bool peernet_has_id(const struct net *net, struct net *peer);
diff --git a/include/net/sock.h b/include/net/sock.h
index 173b37b2b8bb..7562a73ac29d 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1781,6 +1781,7 @@ static inline void unlock_sock_fast(struct sock *sk, bool slow)
 void sockopt_lock_sock(struct sock *sk);
 void sockopt_release_sock(struct sock *sk);
 bool sockopt_ns_capable(struct user_namespace *ns, int cap);
+bool sockopt_net_may(const struct sock *sk, enum net_right right);
 bool sockopt_capable(int cap);
 
 /* Used by processes to "lock" a socket state, so that
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 52c2bd44778a..d211631f8c42 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -362,6 +362,64 @@ int peernet2id(const struct net *net, struct net *peer)
 }
 EXPORT_SYMBOL(peernet2id);
 
+static int net_right_cap(enum net_right right)
+{
+	return right == NET_RIGHT_RAW ? CAP_NET_RAW : CAP_NET_ADMIN;
+}
+
+/* The user namespace over which @cred needs the capability. NULL: none will do. */
+static struct user_namespace *net_right_ns(const struct cred *cred, const struct net *net,
+					   enum net_right right)
+{
+	return net->user_ns;
+}
+
+/**
+ * net_may - may the caller do this to a network namespace?
+ * @net:   the network namespace
+ * @right: what it is that the caller wants to do
+ *
+ * Return: true if it may, which is noted as a use of privilege.
+ */
+bool net_may(const struct net *net, enum net_right right)
+{
+	struct user_namespace *ns = net_right_ns(current_cred(), net, right);
+
+	return ns && ns_capable(ns, net_right_cap(right));
+}
+EXPORT_SYMBOL_GPL(net_may);
+
+/**
+ * net_may_noaudit - the same, where a no is nothing to write home about
+ * @net:   the network namespace
+ * @right: what it is that the caller wants to do
+ *
+ * Return: true if it may.
+ */
+bool net_may_noaudit(const struct net *net, enum net_right right)
+{
+	struct user_namespace *ns = net_right_ns(current_cred(), net, right);
+
+	return ns && ns_capable_noaudit(ns, net_right_cap(right));
+}
+EXPORT_SYMBOL_GPL(net_may_noaudit);
+
+/**
+ * file_net_may - might whoever opened a file do this to a network namespace?
+ * @file:  the file
+ * @net:   the network namespace
+ * @right: what is to be done
+ *
+ * Return: true if it might, going by what it was when it opened @file.
+ */
+bool file_net_may(const struct file *file, const struct net *net, enum net_right right)
+{
+	struct user_namespace *ns = net_right_ns(file->f_cred, net, right);
+
+	return ns && file_ns_capable(file, ns, net_right_cap(right));
+}
+EXPORT_SYMBOL_GPL(file_net_may);
+
 /* This function returns true is the peer netns has an id assigned into the
  * current netns.
  */
diff --git a/net/core/sock.c b/net/core/sock.c
index cac93cba3c84..352310066e35 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1172,6 +1172,19 @@ bool sockopt_ns_capable(struct user_namespace *ns, int cap)
 }
 EXPORT_SYMBOL(sockopt_ns_capable);
 
+/**
+ * sockopt_net_may - net_may() over the network namespace of a socket, for an option
+ * @sk:    the socket
+ * @right: what the option comes to
+ *
+ * Return: true if the caller may, or if it is a BPF program that sets the option.
+ */
+bool sockopt_net_may(const struct sock *sk, enum net_right right)
+{
+	return has_current_bpf_ctx() || net_may(sock_net(sk), right);
+}
+EXPORT_SYMBOL(sockopt_net_may);
+
 bool sockopt_capable(int cap)
 {
 	return has_current_bpf_ctx() || capable(cap);
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 1281c42a3456..69c92fad0a32 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -899,6 +899,27 @@ bool netlink_net_capable(const struct sk_buff *skb, int cap)
 }
 EXPORT_SYMBOL(netlink_net_capable);
 
+/**
+ * netlink_net_may - net_may() for a request that came in by netlink
+ * @skb:   socket buffer holding a netlink command from userspace
+ * @net:   the network namespace that the command is about
+ * @right: what the command wants to do to it
+ *
+ * As for netlink_ns_capable(), it takes both whoever opened the socket and whoever
+ * sent the message.
+ *
+ * Return: true if both may.
+ */
+bool netlink_net_may(const struct sk_buff *skb, const struct net *net, enum net_right right)
+{
+	const struct netlink_skb_parms *nsp = &NETLINK_CB(skb);
+
+	return ((nsp->flags & NETLINK_SKB_DST) ||
+		file_net_may(nsp->sk->sk_socket->file, net, right)) &&
+		net_may(net, right);
+}
+EXPORT_SYMBOL(netlink_net_may);
+
 static inline int netlink_allowed(const struct socket *sock, unsigned int flag)
 {
 	return (nl_table[sock->sk->sk_protocol].flags & flag) ||

-- 
2.55.0

