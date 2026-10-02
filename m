Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE263D16FD
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936258; cv=pass; b=M7nN2llilSgYvNHxu3Ccqj+JiNrMIDvbYJx1dviQ4IhwhSku6dvTiBUb0QEsTtm2y/ZeCFVfbN33rEFUkdW51RR55C4e2WpGXeMED7Clwo+vaxZlLP9Mnf1SkbUW/qUHq19FXU1I3qcytkGJasmQw4f8ePeWjwAy/PqJOTkespM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936258; c=relaxed/simple;
	bh=ZckUBzuxfDct7Xtg49y5TXXNnoeTTdLGKQnVGpqLnmQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mv76HPT9LxicH6zMeKgyCDnhhcxLqC27HrwOoLwVDnV4a1qbPQCGcxHYVnODPYo9DmGIAohY1bp7f0EwXk8IkNv0FKdx4jXs+PgTKAF+wwYcfT/ZCrxoOC2QEWC0gbf2II0qIjXi/4LFTaJpC/MPNMcH1pYBioUXBEHaX8QirVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EonNVIOl; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EonNVIOl"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba3b8a5187so2795703e87.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Oct 2026 03:17:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790936255; cv=none;
        d=google.com; s=arc-20260327;
        b=T8Y02eyFBhmWgu0tjfk+0b8BivsbfsUGLdPn/GWbdODfLe88O+rBpuDzKGL+r1+d8S
         3ylQLfV5y+EedHxCYTHicjCUACelpzG/+twX/QAHwtcV72n1lnXjad+gQ9HByp+QIxsQ
         24HVB8L33r2BKJGNJTlm13zDtCE2TibFL8+zgMPZZqs36YLpnsU98boaAu1vGwLa/Vl3
         YKm+UZGdaApZYRSUaUE2MajBORJkhBYiaWx/aUoIFc43E2FmvGOyFK5ltJ1DkFwszBLS
         +ro8DUhgrYV+nvX5hHmwBmTH6NKg2k538A0Rz43KsdsIDZKBh0zTIhTp2nTKVg88aTTb
         MbHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:sender:mime-version
         :dkim-signature;
        bh=Pu/ssd8DugN/kj01xDDdGW2HkDyQcHTA/d4qIgsVPkw=;
        fh=iwSNYB5TTTpVJ7mIYOQ+y13SNI8qU+/J0C2fWIhfZi4=;
        b=jRJlPveExa/Q6drZDXYselU9K9gt2XfE+JVteJXnJt0iReaYd307PnZqG61oBO+rBn
         UykkGNokzckd/MTcDjnVkLcDW0iREaDZOXX/pVz1q28vRV6S4gu3nLtHy1S7vigZWpS6
         7BrH+57WpOCfN8QWBk2uJPwb0GG1/WKXKa9G7D9vPgmROH35S6G5bxe6x/mLYi1Y1z3g
         fUKgU8kd0WUdX20NEaJyE6jv0erUm46k1npd9Kt5lKgpMlpwtPPcPU/46icQvkiGJEwy
         qUjOH1uIDXmadSVLrAb3zlgdmrhV/+FTyXUraNEbBNQtsbbMZwgmdqMXoBy5C8NXjHik
         /GCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790936255; x=1791541055; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:sender:mime-version
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pu/ssd8DugN/kj01xDDdGW2HkDyQcHTA/d4qIgsVPkw=;
        b=EonNVIOlF+cFCJCYJYKU6KJkZjZNdysmtCPlTbyQKrOXOPlzwfdw+EUCRclT1VUHoA
         WcMBiaQcH6nqw87mDTcNbmHGcIgboJshCez3jYSWcgnIwX6dxLjaVmc+VdiTQWqtt7EV
         vhFImDC5fv6IhMrmaY4F9X9fvc90nkJHu53T7Mum3Zx0A+HWVDqkPNlCQyrLl+Rey6Pb
         umqnjvXTh++rmf2BIE7H6+/MGNkq2j12ZvgiUmVquWUaN8XEWMUkoYlJnjG7HmL7VIKc
         VN6688EVh6gJXsgPuczbueH3X+MeAhgndBvLHD02uc7cXWlY881dJRQVzp9muZcxOKGA
         dc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790936255; x=1791541055;
        h=content-type:cc:to:subject:message-id:date:from:sender:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Pu/ssd8DugN/kj01xDDdGW2HkDyQcHTA/d4qIgsVPkw=;
        b=zl3f9JsSfngcfnf05Y/wrWVB7fNMZPuGsp3FE2yKroYInUCXMcGdaK60UWbkHklGwo
         w3ur/+Q1DPTFIudOM7sgWfLRojZU75aIihCHcA3UzDDrLV1O2K1nYBT7tGxUUTwzSdup
         Y6AGZJNxYwKjW4obEx6YqrHxAa9e/lDqOw7KXHUiebzl4d99+uIhYgaDv4fXeggLFWmf
         lsCSAuyDJBN2OUjZRJFBSSp891kmyvVLxp+ihrE6wHrq2ZwjofvUMqmfy9rBTVeGHYCy
         CbVtV8S75rI0WC3WzkQTcAJZOxnOomeHwmptNjduAJZc1m/wtv/2Osqd8zT5MooYbirh
         VCyQ==
X-Gm-Message-State: AFq9FYJnPKrbtpRinslGRhIhW4VkuI6okyHBcXuRHbwRmZhT5/MaqaJV
	i1EK8JWZP5TCVEA2D5zuXbLHX4bPLsRHdXa70SIoDO3B6EjPWOz/JvCsFyUY78UdeTIe6HYLIlu
	OUjhQPybkTozlitxjZ9nzuwbBF+3YRUk86dfjnIA=
X-Gm-Gg: AYBFou3YwAvKJD4pFDkoDiLxOsZGHk2ywFUVv6LZelQ7th13RcII46eFqCPs6HrF++l
	S/bOgiKBu04kSch9ORQQIU9pqwqVTZOpUguPvEbrE6QZRb8dSBE3nr8EyjE04MoRWIp/lMOMqIP
	U3te2tXWdwKS9CSLHb0Sj2NZbjOnDB7cmhWZ26LJSvCrV8iWHeFsX/vZmvcZ+cdzWgv6DNvzsSr
	INzVqvXcuxvP0hp65XMGqmiofcAe87HYqKqh/gZf/qZYlg7L3NxCC776danf4MlJK2jcdtYFidr
	wuN/9L7R96mZEZWsPRt9dwwPrPHAYEOkjYzNaP7kIKyocDHll6OooOwxsZVMZt9UVYHAZeBwong
	MSQ1cRzgLJOUo
X-Received: by 2002:a05:6512:6c4:b0:5b8:b3a5:827b with SMTP id
 2adb3069b0e04-5bba4bad0b8mr860497e87.40.1790936255129; Fri, 02 Oct 2026
 03:17:35 -0700 (PDT)
Received: from 254448290189 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Oct 2026 03:17:34 -0700
Received: from 254448290189 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Oct 2026 03:17:34 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
From: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
Date: Fri, 2 Oct 2026 03:17:34 -0700
X-Google-Sender-Auth: b1pJKT9Z1GEu05wo2aWT0OXX6Hw
X-Gm-Features: AclHuK-XNwrA2EcOc4Po4ch6BRKkhiv-zVlU7CDstfm5bS9uo236ZWXHKZYEhbU
Message-ID: <CAANnmVA26uyaCx6_Ph=BpdUyfoNH79KzparVquuv=BWqa_Mp7Q@mail.gmail.com>
Subject: [PATCH] ufs: verify cylinder summary size against cylinder group count
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, marco.crivellari@suse.com, ali@iusegentoo.com, 
	kees@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The cylinder summary buffer is allocated with the on-disc fs_cssize
value in ufs_read_cylinder_structures(), but it is indexed through
fs_cs(i), which expands to s_csp[i], with the independent on-disc
cylinder group count uspi->s_ncg as the only upper bound - see for
example ufs_new_inode(), ufs_free_inode() and the block allocation
paths.

Nothing requires cssize to be large enough to hold ncg entries of
struct ufs_csum, so on a crafted filesystem image where cssize is
small and ncg is large, every fs_cs() access is an out-of-bounds
access: a read when scanning for free inodes, and a 32-bit
increment or decrement past the end of the kmalloc()ed buffer when
an inode or block is allocated or freed.

Since the summary arrays are only set up for writable mounts,
triggering the out-of-bounds writes requires nothing more than
mounting a crafted image read-write and then creating or deleting
a file.

Validate at mount time that cssize covers all ncg cylinder group
summary entries, and reject the image otherwise.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
---
 fs/ufs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 3569ac92b065..2052d5225d03 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1139,6 +1139,11 @@ static int ufs_fill_super(struct super_block
*sb, struct fs_context *fc)
 		uspi->s_csaddr = fs32_to_cpu(sb, usb1->fs_csaddr);

 	uspi->s_cssize = fs32_to_cpu(sb, usb1->fs_cssize);
+	if (uspi->s_cssize < (u64)uspi->s_ncg * sizeof(struct ufs_csum)) {
+		pr_err("%s(): cylinder summary size %u is too small for %u cylinder
groups\n",
+		       __func__, uspi->s_cssize, uspi->s_ncg);
+		goto failed;
+	}
 	uspi->s_cgsize = fs32_to_cpu(sb, usb1->fs_cgsize);
 	uspi->s_ntrak = fs32_to_cpu(sb, usb1->fs_ntrak);
 	uspi->s_nsect = fs32_to_cpu(sb, usb1->fs_nsect);
-- 
2.47.3
