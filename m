Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892498;
	b=rlR6ZCOShtTjKYkQKWsL7hAvRGwzj36WR77jOwsGL+cjOdMEW388lqiUaWLuSnRnmuF4
	 lzFXODfXBajlfatTeTEqX0sI3zHLIndU592/mTlXPEq4PFrY9DVzgosjArKP/JJad4pE3
	 FSKUhwMbFREY7dDi5h9BOat+t2+ecV0Q4W6+41FM9O8QAubnbBnI5S+PB+XPcxDYniPEO
	 SVuhjJfMus9LxHRWsz7rhaWP6otFhNy26CTkTDXFidnqLDmAetNO8XE9dISiXiPJOq9iH
	 MmCqLhqDNe5YC0FxueVnS99TcqyfAisBl70BMKfIrDdbtz9mdQTJ0c95G0KFSwNH6KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Kz0PHWKcByhyF/gvlB7if/6abGMtYwQ80lEx67ATnrg=;
	b=njrhUMhwiC1Sa9MTfTpNu6NKsgFnoQKYp5H/ds0/Uwt7zW2WW2V+NcKt1riUvIJ9pLcR
	 XYoH01i/t0JvOFuXfYronX+/0USygjFUSEiiL410g6mfRe2ICLO7olRkdbI0iB5Z+wwt3
	 8sCstgqvPJJMR+lrIkC8ESkiwUzwcVtY0M6Dfn1trw9j3iGxY+9gOkbB98Dn+z93kwdsa
	 NK8NxmQTVi/F4E0N5SI/5zhRIPZR8yVLYxxPRx3Byx/NEYoJrbpFAhSFIECDtiWj39IxX
	 z4E8gjgc+SbsJR02m9EoQ27oLKS+vimSskQQEZRk4v0UnsV1C9qOok5tUhvVkl3oSnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=okYjACgm;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA824606A328
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA824606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=okYjACgm
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91c7a0c1617so27219966d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892497; x=1794497297; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kz0PHWKcByhyF/gvlB7if/6abGMtYwQ80lEx67ATnrg=;
        b=okYjACgm7VGSbm5mvBeAcVOR5vXf+V9s+Un2s5ENVQC1OmFxAFRjqcOsvZBMPLl3iQ
         o3RBzyHNwWHhgm595K0sbVAhhgOWOQRS3VsbRZ1qif53GmJuhoSXYzYEc4ir6RGvyktp
         Q5KV3BaeVpUw3pT9UhvPhDWqQg+YvuOMaCtx6lipyUn0nFQmqN2S3Al2j9o4v0QXYqRK
         qO5e62lvsXDauNRhQExOuf4bqvojvnGEcJNL9NcsXixjZaG040QD/gvEsQiiP0cXScP0
         oMe/ZpQ7AEJGZtO9/8EF84JyfEXE8s4UfqExcsJ0iz3jZ2cOWrt9NeT8iD6G0KLcq8xR
         9HxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892497; x=1794497297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kz0PHWKcByhyF/gvlB7if/6abGMtYwQ80lEx67ATnrg=;
        b=bg2rYLO/UPeUFQvYtywplebXn1FNgK6q9ARJOnVqZsqrWxeiyod9F4p1GLXqXjFEH/
         71sIbgNIknPwVQUXGbZVBSf2w0iIMH2obGKk8QBr7/zg8w0nmwUiPPRlYtee+AqMn1If
         o1dMfb+6YFbZBjX30SRLj9rJAPJknN9pPy6Riic732Mnn3thRFVNlbY9qoQ2pmi3AerA
         AqshCLrdju8pl/XPQpWO8md20WMYRcWCHSnbOkX7PwH78XI/45COb6nJNzzT27B2KnfJ
         06alADzwXb5S80jALLrlPi2JW6Su/GutN0Bz+zzO/u299ymaKUSlGKbyBlrMtm24jI9j
         zluQ==
X-Gm-Message-State: APuU4Z9V+dTI80gw1L2UaxZHE0t2f5WM6kfwM2mGmIvCb02rcaiuqr1N
	fYK5CrAh9s9FwtQAm8PlID6J8mQ7VTHjrH2KMHS4hg7L+tvqXJmrAd7DqsUejzoDnq0=
X-Gm-Gg: AYBFou2VUr6bmTcBjzHCBw3aikFyaR6SNqsoE+41eAsdiOG+Xo38u2TDuzEKM1WbzXA
	/gJOeGzx3KXAIMqUO1mosveTBQq5h7X+c6u3+jKiHzfyPwYkKp4Bqx8xi4GqblRkctI2ZdJ6NlA
	IyKTPrtC/mOQLReoDVV+P5DdhQ0QNHzTfQdVbLOkgV53hxnZo66FeCGuuu2230SGzq6gcPVhsQR
	sHlHHAiEaoKcC1IKxeQOnEUnAUXh0hUioQb4wAC2WJsenqminZME9fCMkJl7vXgdmsZ4zJo/mn8
	xYyMoN6HNJQIvsWVbP1SqHNYH1K7mY3OIACYR8b4qRlU4x+Bdo46icHzHU/6AaYuEmrPdmJc58b
	CBkoOWvxT79jdQsCxQHXzAwCBJ6jiDc9FfRI+ndSJ5gMIDzECvEEseZZ08VNgY5NBQN3NmC4ZJC
	MeEWjwJVcexhCA+3qjmWKDhXSwy5lELieqDFyxUqC7tg29XFrxVpceU/4DGSjdF4k59diQitkYJ
	HsvKx5aZS60D9XrNLNNqSCzw4bKn3ywMlcCwiXMzThDZjZU+scJdfnUBXpKzDDZhiqpSkFoOfIk
	aNe0zoGqRBEJ+HFuiJROqMU76eroEc45e7XRp973xewXLV9l49dprfLOlA53BHrePJc=
X-Received: by 2002:a05:620a:6191:b0:93f:1437:2e58 with SMTP id af79cd13be357-944216ee050mr3073697185a.56.1793892496646;
        Thu, 05 Nov 2026 07:28:16 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d48694cfsm487038585a.36.2026.11.05.07.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:28:16 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:03:08 +0000
Subject: [PATCH RFC v3 76/90] rtnetlink: use net_may() for requests that
 change state
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
Message-Id: <20261105-b4-cells-v3-76-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890936; l=5219;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=XoA8BbdVLFstFTRRQB2rIoFN5ABiwloSZ4q7Qt5LBx8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIpXDyOZBYdzTDWL1l/kopzbAXnbdbXC+LWnZGkccvvay4VHDUbhdHJ+jo4myg4NSNTsIFqt2J0
 pmcbwSrC8BgM=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

rtnetlink_rcv_msg() has a single CAP_NET_ADMIN check for every request
that is not a GET. Pick the right from the message type instead:

  NET_RIGHT_LINK      SETLINK, NEWLINKPROP, DELLINKPROP
  NET_RIGHT_LINK_NEW  DELLINK
  NET_RIGHT_ADDR      NEWADDR, DELADDR
  NET_RIGHT_ROUTE     routes, rules, neighbours, nexthops
  NET_RIGHT_TC        qdiscs, classes, filters, actions, chains

All other message types keep the plain capability check.

RTM_NEWLINK either changes an existing device or creates a new one, and
that is only known after __rtnl_newlink() has looked the device up. So
rtnetlink_rcv_msg() accepts either NET_RIGHT_LINK or NET_RIGHT_LINK_NEW
for it, and __rtnl_newlink() then checks the one that applies.

rtnl_link_get_net_capable() checks the network namespace that the request
names as its target. That is the namespace of the sender if the request
names none. Convert it as well, and keep checking the target namespace.
All of its callers pass CAP_NET_ADMIN, so drop that argument.

No functional change. Every right used here maps to CAP_NET_ADMIN over the
owner of the same network namespace as before.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/rtnetlink.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e141340172ce..df97309a9622 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2737,7 +2737,7 @@ static struct net *rtnl_link_get_net_by_nlattr(struct net *src_net,
 
 static struct net *rtnl_link_get_net_capable(const struct sk_buff *skb,
 					     struct net *src_net,
-					     struct nlattr *tb[], int cap)
+					     struct nlattr *tb[])
 {
 	struct net *net;
 
@@ -2745,7 +2745,9 @@ static struct net *rtnl_link_get_net_capable(const struct sk_buff *skb,
 	if (IS_ERR(net))
 		return net;
 
-	if (!netlink_ns_capable(skb, net->user_ns, cap)) {
+	/* Where the device is, or where it is to go. */
+	if (!netlink_net_may(skb, net, NET_RIGHT_LINK) &&
+	    !netlink_net_may(skb, net, NET_RIGHT_LINK_NEW)) {
 		put_net(net);
 		return ERR_PTR(-EPERM);
 	}
@@ -3610,7 +3612,7 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto errout;
 
-	tgt_net = rtnl_link_get_net_capable(skb, net, tb, CAP_NET_ADMIN);
+	tgt_net = rtnl_link_get_net_capable(skb, net, tb);
 	if (IS_ERR(tgt_net)) {
 		err = PTR_ERR(tgt_net);
 		goto errout;
@@ -4109,6 +4111,11 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		dev = NULL;
 	}
 
+	/* A device that is there is changed. One that is not is made. */
+	if (!netlink_net_may(skb, net, dev || !(nlh->nlmsg_flags & NLM_F_CREATE) ?
+			     NET_RIGHT_LINK : NET_RIGHT_LINK_NEW))
+		return -EPERM;
+
 	if (dev)
 		return rtnl_changelink(skb, nlh, ops, dev, tgt_net, tbs, data, extack);
 
@@ -4220,7 +4227,7 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	tgt_net = rtnl_link_get_net_capable(skb, sock_net(skb->sk), tb, CAP_NET_ADMIN);
+	tgt_net = rtnl_link_get_net_capable(skb, sock_net(skb->sk), tb);
 	if (IS_ERR(tgt_net)) {
 		ret = PTR_ERR(tgt_net);
 		goto put_net;
@@ -7067,6 +7074,49 @@ static int rtnetlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 	return netlink_dump_start(ssk, skb, nlh, control);
 }
 
+/* May whoever sent a request that changes something do so? */
+static bool rtnl_may(const struct sk_buff *skb, int msgtype)
+{
+	const struct net *net = sock_net(skb->sk);
+
+	switch (msgtype) {
+	case RTM_NEWLINK:
+		/* Which of the two it takes, __rtnl_newlink() finds out. */
+		return netlink_net_may(skb, net, NET_RIGHT_LINK) ||
+		       netlink_net_may(skb, net, NET_RIGHT_LINK_NEW);
+	case RTM_SETLINK:
+	case RTM_NEWLINKPROP:
+	case RTM_DELLINKPROP:
+		return netlink_net_may(skb, net, NET_RIGHT_LINK);
+	case RTM_DELLINK:
+		return netlink_net_may(skb, net, NET_RIGHT_LINK_NEW);
+	case RTM_NEWADDR:
+	case RTM_DELADDR:
+		return netlink_net_may(skb, net, NET_RIGHT_ADDR);
+	case RTM_NEWROUTE:
+	case RTM_DELROUTE:
+	case RTM_NEWNEIGH:
+	case RTM_DELNEIGH:
+	case RTM_NEWRULE:
+	case RTM_DELRULE:
+	case RTM_NEWNEXTHOP:
+	case RTM_DELNEXTHOP:
+		return netlink_net_may(skb, net, NET_RIGHT_ROUTE);
+	case RTM_NEWQDISC:
+	case RTM_DELQDISC:
+	case RTM_NEWTCLASS:
+	case RTM_DELTCLASS:
+	case RTM_NEWTFILTER:
+	case RTM_DELTFILTER:
+	case RTM_NEWACTION:
+	case RTM_DELACTION:
+	case RTM_NEWCHAIN:
+	case RTM_DELCHAIN:
+		return netlink_net_may(skb, net, NET_RIGHT_TC);
+	}
+	return netlink_net_capable(skb, CAP_NET_ADMIN);
+}
+
 static int rtnetlink_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 			     struct netlink_ext_ack *extack)
 {
@@ -7093,7 +7143,7 @@ static int rtnetlink_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	family = ((struct rtgenmsg *)nlmsg_data(nlh))->rtgen_family;
 	kind = rtnl_msgtype_kind(type);
 
-	if (kind != RTNL_KIND_GET && !netlink_net_capable(skb, CAP_NET_ADMIN))
+	if (kind != RTNL_KIND_GET && !rtnl_may(skb, nlh->nlmsg_type))
 		return -EPERM;
 
 	rcu_read_lock();

-- 
2.55.0

