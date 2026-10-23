Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792787992;
	b=NAVOH4CVjgD+y2Ska1I/rhs8Iwtvf8B2ekmUsb4Zplj3zKGXSSXk3BJhxP11UZ5eC5oF
	 1nk/l5g25Y6HOgdZqebFTpTWvJG2ukw6Tmk36fldHh823PuXpNmf8jRSGgt4LNtyI/HB1
	 E0Tfx3tdxREJWKgenR5nZ10uyURWIbwea+eGeQPtHrPwDiOUxxATEKCIsaAd1jZOVH3nv
	 j0J0/8He/zUb2XgUw+ZhfI8qp4GDL72aE8sckV0YpIFQlGR4PW/QiRczFzjAdTKmkp5XW
	 UQlzmVhn+uhSLaRHxSAF96J0U4z/VJ5bCQLwo/AMHWUmu7XqRYauLnhJIlc3ryjlKsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792787992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=67VFriUns2Mb7cXVKJ9BBxQRXg8N4dY24PJfmsDGRgU=;
	b=v+QKa7Suv7yXVnq2/+Yxmr7l5QS0hNfXNJ/UO8w19/+Mu9CbmYLyzgjaYzsqvF7DnpfD
	 IDqUTQmPVgznXkavjEUVwvfyp/jG9ekgpwmf+Dy0r6FnJdhCuZlC8nrXrP69GSg0gFqgi
	 2Yh+8D/XAQLP248gEju9M9NrkWHpb3JkxuTfejwFxLK+h2HX0LM0uStna3DpAOftybGFM
	 JeO41V4BK8bUxNQdHxlZH4LTPlXJ8ixpH/xJLfxtjJKSGV4MvWA910nn9sj54DkFaIaTI
	 b9z0C7kJwOVhTVfy52andDRKbGj0HrhbPl6bHM2FuoZ/IOBk3LZCrtpcSwFlEIeK3Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=EC4u4kM+;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9C0606A33B
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 20:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C9C0606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=EC4u4kM+
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f2ed2541aso100107185a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 13:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792787992; x=1793392792; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=67VFriUns2Mb7cXVKJ9BBxQRXg8N4dY24PJfmsDGRgU=;
        b=EC4u4kM+S+fjv4gCfuKVx1/xI9e9EQEbCORIa+iZOx3Rjyqi7kWhSevj2csTkRA81j
         aPphX6k4zK0VHqeQCiMn5PS3u3DsM8I4Eip89MMZULwA2rJUaOjvyp4o3zpi9Ms8IHIk
         bWES1TF9Suy8JcMWsv/SblfTYA/QZnOfhevgRgMx+bHt5wvX1K3UnSL6MZYvtv/Dtso4
         m9DjYN9eZmCWPCnT2DP/KrgvbqB+bMd+465WHgvVx6pECAEOoA3X2thMuXakjDAfo9wW
         lLGgB66LwwVgV803jxjpHyjZlN8tFABDBLt89vJVM6lIVz+5hCMhJ35zlTZie82G9YGB
         2j2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792787992; x=1793392792;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=67VFriUns2Mb7cXVKJ9BBxQRXg8N4dY24PJfmsDGRgU=;
        b=BVOP0wm0kTtBY1LVhg9mDBriS7sKmxwfNLiAukk/BOQbFcjLWpDJutsOzvYyhxw6cE
         0NMJG85J+sfzrHMnsg89u3d/Y/ke8KK62Cy2lMcaLq14U37ZRltf4NTgiLdC5p+dikjM
         9nRD7mkk7Xdtf3lC4MlurlPTCUCfVIRa8atUySTd++07Vd3PbJh3zzhO+AgFiwACh0Y0
         smA/azNoJwpTeJv0HkGwG3Tk8BBKtaQKmev7AsaXiz48UNFYXHwHeASt/JYqZUKxNWLi
         Fdu0ImVzK5VHjw5TKlgz3/vr9TvIQZLG1TICH7U7b92wGJKUrUtYMdQKyYk2oRH3vw6s
         XMsw==
X-Gm-Message-State: AFq9FYK/3wUlx3jQGFDbBjDpmEX4/Q2PxnuF06wfdLs2JkIdPXX2UpvW
	fVODEm0s8p45cRHpTlDH02vIT5JxRuzZ3uDR+XK3DwPtfWLEeu65gpcnZsSMW9dwh38=
X-Gm-Gg: AYBFou0A2X7lI45IXCVDiV6czXwrQdoRIXmAc4h7CIVLgJql0ha31zvgtOKOeHE0DFY
	J7gAiQOhqQXjaYx1G7s5y7U4xvLc3mN+S2xMKL5tm3pGgVaTuH17Qsgtar/t1oTzcYMzGIviHyb
	o8xtlr13056V80kmDtrp7XZgxAaOzQPiuutKcpUuGgOYkpn7F44kkdl0e9m0rgHInnGn4C9vVk/
	Is15rJ6UGNP95lVTN6Xs+bZ6EkpM+PRMy5ajF28/vaxoB/+Y71mWjHRaqvNNVK6tcN5bu9ny9CB
	sI+y+y3BxvHaMd266P82C5eHMAIftbNP8fiyfsKOciv8AuEVZZpj7M+mtK2mh2nNDjKz3TdiGZZ
	6V0b3fXsj4Uu06aFZvBxbsCP7cOruk6fC21S5wceZaIu42GLrmEREblg65Mw6YREvthuvjg2P8z
	5J9mKiBWJuYT9T9H6uCy0CsQ4LPCx62J+LqdadzYOJIi3YIUktGGK4KfKuBce2FYL0ru0Ki7C5w
	ah6kXHO0kAjZIy+6wkEFFQHbFsqq0WfoQF5Vmga4fjhBWuBUKcIWtbRaT+17AE2GrGNoF7pcGwI
	U2Rrl7+/cixxeUwRbOU=
X-Received: by 2002:a05:620a:1a1f:b0:93e:c173:f691 with SMTP id af79cd13be357-940efb284cfmr21595585a.37.1792787991671;
        Fri, 23 Oct 2026 13:39:51 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0a771c9sm2527985a.34.2026.10.23.13.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 13:39:50 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 23 Oct 2026 20:39:34 +0000
Subject: [PATCH 5/5] fs: make umount(2) of the root killable on s_umount
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
Message-Id: <20261023-b4-s-umount-killable-v1-5-844a341ff1df@toxicpanda.com>
References: <20261023-b4-s-umount-killable-v1-0-844a341ff1df@toxicpanda.com>
In-Reply-To: <20261023-b4-s-umount-killable-v1-0-844a341ff1df@toxicpanda.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792787980; l=910;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=p9A3xo21a9LbtEzxaqKkQt76AUeVVyVBHPs8REsoquo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKV1DHWOfy3oLYOIU6FV1hzHYcxlv+68Rfc9PxOe1ez+w+LSKrg0baWQG7s+Z6mhqWsnfd9BzpW
 EaFgGR8ttJA4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Unmounting the root of the caller doesn't unmount anything, it remounts
the filesystem read-only.  So it has the same problem as a remount: it
waits for s_umount in D state, can't be killed, and keeps every later
reader of the lock waiting behind it.

Use down_write_killable() in do_umount_root().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/namespace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 837f531e494b..b874accabf76 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1897,9 +1897,11 @@ static void shrink_submounts(struct mount *mnt);
 
 static int do_umount_root(struct super_block *sb)
 {
-	int ret = 0;
+	int ret;
 
-	down_write(&sb->s_umount);
+	ret = down_write_killable(&sb->s_umount);
+	if (ret)
+		return ret;
 	if (!sb_rdonly(sb)) {
 		struct fs_context *fc;
 

-- 
2.55.0

