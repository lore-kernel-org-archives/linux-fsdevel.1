Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892583;
	b=JMUarP+mYgYYuJRWzgfw9A/oEwoPAyUusOoj8mBxb2g+kaVGT0DfVm3MPQgByxlQIhY7
	 qTz3Zf2e2fAm0jX0gz6Id0nspOB6Ql6sAI6AI63uILSWEnFfkEmTr7Dxx7c0OIKzG8l16
	 HTbrM2iHY2s9mQZoiTemJVBJQRHZK1KJg1kxpyW88OYp6S4E7fwb1f9dwXLtbCJqmlexU
	 gHaLc/9EpuKEXAQhAt0zgD1MdP6/u7vIDdzKwZpZ7qvYCyijn7FGBOV7ijwKDyHfXrg18
	 i3/JKMsgA8VDNSeaJKrwPrKyJlRbIaUgZzQzzra5UZBvpdmep2vVR7eEYU9nteK6Uuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892583;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=og1+N7jhageKspGzi0Ed7TaLd17MzbrlGOOU2ay2tog=;
	b=MLqoGSXGw5DqpQp6yhUlUEAQ53khszLox5lfEbhdllrbIOTlrxUBfNVqbZhn6pFYLiIy
	 Of9hgwcacHt1Y7v7YEDMLme6yXXneOksMHxiaMzUQZo8DvHYu3JLi9lkSm5R48o4MbFmH
	 lUraiUP/k9sFAGytf6IV9ipWU/yDTmcEp6t6U5brBjR7krkYColu7DxP8rpITJlqC7CYE
	 PQGo6aqv8JzFgMEemzhJ5lz5uQ36UZqX/L1VTErsWdis9UGfTavyhHHg1a8Pc8NwJpPoO
	 Zqh4PE/1AXAfxNm1+wW356fHwP477rKtV0/E+i96om/RFSDhKbtOO18seKPah3X2ipg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=CcyYgftB;
	arc=none smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B23606D83B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7B23606D83B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=CcyYgftB
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6dde81a6820so1284795eaf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892582; x=1794497382; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=og1+N7jhageKspGzi0Ed7TaLd17MzbrlGOOU2ay2tog=;
        b=CcyYgftBoSsbCDySi51V7MlnY4uBcriQ5+9DPQgmfyC8buGXiB1LCPnorJ7oCsocCV
         ypg2ddwIIOHp0OPDeTaLKB05Rjdu17gUh08Zsc/TaP1hVEam5u2Uazd4/f9I4KeE4ne/
         nYwQiJ05zUP5KuoN/Qr9Bk60b01vGd4Cuti0yJ5pneLCKofwKbeKLF3sXxeyoU3U76Gc
         GyNp/1CBELpm/q8t6x5hxANw1N019hZFGSRqnpQJmTjE/g0JorrdxZDHfYI0KB6jdgfI
         hRKiVt+hdj9etmC2Ly1yJ0VlI1yHU/yHMqRwkeAiA7N7Aiq26ZndHwjUs35MwvrMQskf
         IsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892582; x=1794497382;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=og1+N7jhageKspGzi0Ed7TaLd17MzbrlGOOU2ay2tog=;
        b=PlZRV1Zc7Je3NTIw+mIN92G78aCyJvfQY59YgvEhIC0nGrcpGF2EuYj+hOFV/zo0X1
         DbkIWaqfLN6OUEgh3cFQnnIXuOqEU9T8kXbJG7rRmigeYx+V7fLXOtE/ewlJ1GSfefcj
         u/oZSkCfxS8AoL1JirGdVfpi4NsHhQtjqvVcPzATONcAazG3aVyiipTGTC+8bWBHfRNb
         0rYHTCt2QFj2Mlztre4JBvi99p1hpYCO7dWY8qQulbXuwm5FALV/KBHvHoJJJDNjbRUL
         VtDhagxi2nMAfmuM00iVK7ZsIzAHxGc8H2CDmK3mFnvgOpna/Zqd3iwaOo8et7ve83KE
         Lm2w==
X-Gm-Message-State: APuU4Z8d4DCkw0447cIFzuTm633EZaOrOwxoIhm4L8tSPQ0pI/dbxMPT
	S+sXxBPCV5YN0aarp94JdRiPCfV6tBf9xodSW19x9kWHwlTay56MK7Flej0NEasmjpo=
X-Gm-Gg: AYBFou3ctJMLo+4nSUkXyvDdQbt7kW5o6KXGmRETnuasq/cw7NcKBLljJxJafbxXY8q
	OzRHA9ANh+CwTVSpUndUzxkLN/PhWgG36hJLwzVXVQfWHO/i8JB43yBiQX2WFjLQ/cM97eGbMTp
	xOjQcQLfXCQ2XOtcWZVuu2JxCKAYcmr9zs0SbqUOdyE11nZYBWTsyqSrNAhuiAmOu+SjkCDhmMs
	rBZiUIs95of+i1FnxIDIaQz43LBkBhicLXmcL6GFufH26JGUWYCsk41Jsv6PjAq2BcXwGOMsj4J
	6pkGbCFV6f3/6NFP0VhzzJlEp212rYocvyna+AO0V92AaU3KctOFbbeTWkYwGHQD91W7FDhHrQU
	Xy89GI/BPb0bOf5bln2b7cd18HbCqYnwsrRV+2YMaouMFKeu7b+0fARXV9+050jcHGjQCTbYdXQ
	8VXyiTu496NAC1zPN4cXLhohZVSypjSvi4QPH3QDAzwjkObfNLc2/3zLa0cpEbhYZbo47Xi/Tp3
	+psbOOauH0t76Cj3Xsr/HNSrdSXHYthLznWPZ80tt9di7riBag+fNZujq6qKdhb5KK1ni8xFFjI
	QkzK5Spkmqn+7dBuhYHExEdqYzfddy8PBRWaOFUKb0dlbQ==
X-Received: by 2002:a05:6820:c44a:20b0:716:ca6a:c0e0 with SMTP id 006d021491bc7-716ca6ac11amr1944338eaf.65.1793892581873;
        Thu, 05 Nov 2026 07:29:41 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.246])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3e603b9sm4702772a34.20.2026.11.05.07.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:29:41 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:03:12 +0000
Subject: [PATCH RFC v3 80/90] net: use net_may() for the net sysctls
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
Message-Id: <20261105-b4-cells-v3-80-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890936; l=1521;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Kgr2KKzA6ehyBynmXRdAmjrH+vzux2Kj9vyi21aEtV0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFMbcGPvnriPVc3tEDAXLk3f+pGA3tqe4I5LX7sQrFXFAjD2YFhW+8qu4zzRXsxV5cZlg5IigUc
 AhZjYH2vH8w0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

net_ctl_permissions() gives a task with CAP_NET_ADMIN over the owner of a
network namespace the same access to the sysctls of that namespace as
their owner has. The handler of the IPv4 forwarding sysctls checks the
capability a second time on a write. Convert both checks to
NET_RIGHT_SYSCTL.

No functional change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/ipv4/devinet.c | 2 +-
 net/sysctl_net.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index ec57948ffbb3..44baea38bec4 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2602,7 +2602,7 @@ static int devinet_sysctl_forward(const struct ctl_table *ctl, int write,
 	int val = *valp;
 	int ret;
 
-	if (write && !ns_capable(net->user_ns, CAP_NET_ADMIN))
+	if (write && !net_may(net, NET_RIGHT_SYSCTL))
 		return -EPERM;
 
 	ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
diff --git a/net/sysctl_net.c b/net/sysctl_net.c
index e190a639eef2..1a79b8a3674d 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -45,7 +45,7 @@ static int net_ctl_permissions(struct ctl_table_header *head,
 	struct net *net = container_of(head->set, struct net, sysctls);
 
 	/* Allow network administrator to have same access as root. */
-	if (ns_capable_noaudit(net->user_ns, CAP_NET_ADMIN)) {
+	if (net_may_noaudit(net, NET_RIGHT_SYSCTL)) {
 		int mode = (table->mode >> 6) & 7;
 		return (mode << 6) | (mode << 3) | mode;
 	}

-- 
2.55.0

