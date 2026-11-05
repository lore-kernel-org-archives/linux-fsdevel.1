Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891896;
	b=goG+MPdV6G3dCU7yXRk3RuMkvu20vOoZdvyZgfAE9avex25neefeberVlbXukRgDy9tU
	 b2yo2BtnOBCIFzOeBTVMLoR9R74Jy4Gxlq2k34TDz77M0a8t+ejt0qmVU+nsc2l/yDn/S
	 CBs1Q+kXMKKvWRgwU0pAniHv/XKdO+oSYEItnqj1ZJAnEBk/l7VxkfdPbnQXEJPt82bAh
	 5aZpwBtfgAzlYbNg3OgYIL6ThqdIC/9LGqvj+xwkpd9lOaeGh3hHtmSTpcXGrokAdUnOO
	 v0+8c3OuTuLf5/iC/hVVj3rQWcp8mg11eyW2XXbVxmsNAXAG9R8Bh9beok5o9U4Vmkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=jNN7xmLiVZyF6Z8erpVxlHPtOJGxm7l+TGrLpW+rRHg=;
	b=dw97JKW3fEuaybae8GzdBLOZOOs+5b0JJ/3lOV1ib63NeBgWNtNlWgliBf8QIUXYd3pt
	 PTVjvbe00DiYQO9ziCaWjS6fX6fQ2cqfQ+zQNFlc7Ujqpy+4zY2C+6BCbkQyiO0Ga2bLM
	 B7xJ6hRXTRpDELKN1S0gcG00+HyKCk33FaEXKxqZarQlCtzAiXW5nC1HWR51Vyz6PqOPu
	 MYDmXfV2kQ2aP3PkYmDZ0N6lA+nWbS13pNeoEXMIy38vBdKJczd66GfhcaSrXy2N71+Rv
	 XhztkJQijv+Ur4aSmFjsIIJ/tO+5ImxYl6sIuAxFVNq04ciaVelySqbmc1HGBZkrhTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=FDODKT+y;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758C0606A335
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 758C0606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=FDODKT+y
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eafa528803so670842e0c.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891895; x=1794496695; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jNN7xmLiVZyF6Z8erpVxlHPtOJGxm7l+TGrLpW+rRHg=;
        b=FDODKT+yCZvX632Ezhykp5+NIog+ZfvjV4ZHP8ElO4cX1z+hJUD03xfZCdtWtK7mkG
         Qp0Lmrhy+4/b1cuNuFv6KOxs4D7I4vevhZYErIXR9iVQonne9p67WuDecz1EA2mUVXsz
         cN+fYjXe3cOIGsqeQ9bMH4PpokCEOargrWTDbuZfr5rlUFUoO/0AwHeazC8ANOQ8k7tf
         ky7+RhM2C2/VzirQgE9yGnC6iLGqjMgpx2akdxAvJLApctKnOu8yONJ6jaHEU8/p5xzL
         jK+JvjRyUmZ0hqzYyAG0lDBd6/VHxTiOGW7qVIOJEs3izWCp1Btn7Aba7dytuktC4U1F
         Ucag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891895; x=1794496695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jNN7xmLiVZyF6Z8erpVxlHPtOJGxm7l+TGrLpW+rRHg=;
        b=PHCmLRQJ1CVTHJ1As0iihnD/A/v/pL9HEavxjLwmgkVj7DulFZIFeXbvEkbTFymjgR
         diuq/jI0wWCjVy/efZ50Ib0D5gl+GPsryhkF7QoGUEohAeSt2EjqANmxP42qFzcxR6V5
         ejsIsg3c69Sm3dqiPGDNa9iMHdBi8fND5kTNxwpsbIqTPnyM5ZBv8Tf4B+nQvrDAWjTm
         iOY0pzWktAfai1K5W25+zpLcxRSjIzp4qfDnTkVBAUzaJGTvDmuHIWgjl7dRdPv8aHNX
         hZImJylHoiuGiJzjKkB8zetb6E+Gr8Sb3gk1lySFa34gJLNcUsTU/O7kB5F1VpgMpbgj
         JK3w==
X-Gm-Message-State: APuU4Z/e+v/8+WmjIol16xGHKDOFHlmFBFm7Cmg4SrwHPR7QdKASVkG4
	uaGQ56r0ZgdI5LvLZHQ66XWm0j8gPv6uT0eerTWeGAVVV1A0qBu1UcSUxtjIljkJO90=
X-Gm-Gg: AYBFou1IpSD7szydWoJgSIlgT2ozCwY7DoRVtjmTHO1qKnsr2Vkpm3PqysYZSHjZ++h
	njsOTavm47Mn8fYJL+12FDuyfcLPzoGnqzcwQ8Qx8UjQXwIk24e5Vx0vmyJzdwaAoYunoxe7INO
	64Wjhdddh0Djm0Z5zQyHgHh7wW7AoRgm0wy1z44cnYESSsUbrsZAbIeOQ51sp4TMqc/zi7/weuJ
	mleycCn4sPDigcV4LbGka8cys6qF3lVZNkmoyeRMDHfteTUTwWc+Z3AZgfVmkdSz9+dvxqri/i3
	VENNIKLfA4RAkowI+k5suo/7RQU6dVl/FD5vOW5Ec4cIyoz/XnAx/4tyceImjcUSzHG/i8qAhkW
	Fr42uIT2mqp/lg1i161pCOczJsMpNJX5gv2fu/t0pHUcvaWLg2z3luj/4fJP1oG4KREyugfrZwx
	hOTIl/etqxyPbmDUFHjiJ/X8Ot+SXEuxb1sI5OZ1HS/q7it/Icl/O046/QcynS2D3L7thcdAtGF
	8e2lzRjKAN16Huiahq8WfxtRXJrvH0ne+3WsC7cvNVq6mJKOB5sn55teRxuNeUzMtzAhrskO/ir
	mxnJrj+qEIwPMeqIQirNdCWCNF8neMI1JtLLrS9lkTvS
X-Received: by 2002:a05:6122:54e:b0:5e5:29f7:489 with SMTP id 71dfb90a1353d-5ec6899f507mr9340924e0c.22.1793891895290;
        Thu, 05 Nov 2026 07:18:15 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.255])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d774dcsm4443181e0c.5.2026.11.05.07.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:18:14 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:41 +0000
Subject: [PATCH RFC v3 49/90] nsproxy: refuse to enter a namespace of a
 cell
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
Message-Id: <20261105-b4-cells-v3-49-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890934; l=1730;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=IILX1LIwrnxWBZrztmHqMqyOMZ8/KSYL4VYD8k3ZAQo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFJkp+7bJCgWrOlQjezAwrMkgj31NOMOyZP6v++VL2xLlGELRhRo9nkdLV49ycUBRzSHqaKGrBA
 BxbPQcDy2KwI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

No existing task can enter a cell. Refuse setns() into any namespace that
is owned by the user namespace of a cell.

This also applies while the cell is still being built. A task that entered
the pid namespace at that point could become the init of the cell while it
has the credentials of the host. Or it could hold on to the namespace and
fork into the cell later.

The mount namespace of a cell is owned by the user namespace of the
builder, and has its own protection, see mnt_ns_seal_for_cell(). The
network namespace is also owned by the user namespace of the builder. It
stays accessible to whoever set it up.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/nsproxy.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 5d6cec2dc4ce..6b9b220a2bae 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -467,8 +467,21 @@ static int prepare_nsset(unsigned flags, struct nsset *nsset)
 
 static inline int validate_ns(struct nsset *nsset, struct ns_common *ns)
 {
+	struct user_namespace *owner = ns->ops->owner ? ns->ops->owner(ns) : NULL;
 	int ret;
 
+	/*
+	 * Nobody enters a cell, and not while it is being built either. Whoever
+	 * got into the pid namespace then could become the init of the cell, or
+	 * fork into it later.
+	 *
+	 * The mount namespace belongs to the user namespace of whoever built the
+	 * cell and looks after itself, see mnt_ns_seal_for_cell(). So does the
+	 * network namespace, and whoever set that up may go on doing so.
+	 */
+	if (owner && userns_is_cell(owner))
+		return -EPERM;
+
 	ret = security_namespace_install(nsset, ns);
 	if (ret)
 		return ret;

-- 
2.55.0

