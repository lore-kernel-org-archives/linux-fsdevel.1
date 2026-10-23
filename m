Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792754966;
	b=KC0GPcETJy3e6h8MXUfp4yxfVjl0s9sRnfeiaObU/xzxr+LrRzmmMy2Sxjqm5DXDL8d4
	 YTQs1hHzTdpdCNR/G2ym5Y9GQMUixsE759IMVy4GCkdS/ijIs/jd8q579s1+q9QR++FP9
	 k3PobN4XCNHLJ4KxYq3DGVW8d/J64ViZeOtZsp026U4ot73EdXvkHB6jfSV62WpQJ562y
	 JCnaEmuM3nY9UwQ4gIX6W4MoIDyKoLG79jm5cHrApOtXdqK/SS2+F4EiQqcbNFta2vYTG
	 K/4L8guACghOfvgNnIZfMRXaMxq036JZqTs2OswffW2S4gHxER66JUmSjJkd2dxsbVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792754966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=siaaH19W0b1cnM6TcR3SUQHduqkChYWI/m2jWbai9r8=;
	b=gid5QdqqCpErMT+0mK+CuTWwrZ7l0laOO2ALrbJYVvRLy+J7PmBZhGB4pXSKM5Fb/Z5y
	 pvMgCPVF5upQ24bA+MK4rTbVFrqqcdB6gfbS/+xDLhrQTadnOzIpDBWSFLplS0xxCnI4B
	 jwSoEwTqkCrRxpBZrRazycrMa+9fn74gXiZ58R+WyuEOeRpH1HmsSTt8yhOpKuUgXUurR
	 xgsz7N6o/26MS9HGAncdi6UiHiTLd+6FT6t776oE7XWPW6PNFWH0k/5e6mNWxlpSxBeRC
	 DHEk+Ropc4SzC8ejIRvm0LHv6wQHYJnjdagZ+D4ZeR3JoYX+PhhAhBw7q4ejYbI6r8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mlvHp1pM;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA88B606A31A
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 11:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA88B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mlvHp1pM
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso5107645e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 04:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792754964; x=1793359764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=siaaH19W0b1cnM6TcR3SUQHduqkChYWI/m2jWbai9r8=;
        b=mlvHp1pM9zfIVT0GFLmeVurTUjPudpQaip4Gzq4FRJ34lOuLYCAMw1XLczsDNPyNVc
         +s6rxvO7PYoQr9DcsqfQTI6zEF9/uG8PIj9IUwC5Li9wxO6Z9fn4Vg5BcDUES1Cww0XN
         gWFnxpAoUj15QGdp1SbwRmesBFYPgSRJA2fCPPLAfhIk1CI88ALT98tXYTFQQHv2PFNa
         03wZ9aaon0vm3/JBESzRGVxI9My2ezsZJU4RujyVuPs9d1p72OhpQBy4bDA/oyjhVIKL
         Hl0ONYWEky46/gR/a97LVhByxGIRva+lWQj4ITkrVbOoIeNtRj00VnrEoSjQSTMiBcxm
         rlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792754964; x=1793359764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=siaaH19W0b1cnM6TcR3SUQHduqkChYWI/m2jWbai9r8=;
        b=Mb/Z0HnS752FBUDr2n+F9ONGAlXqcyyHM9Diik68D3Q/61kpKpy9FAAAEH36uMsAQU
         /5xDCdj3ryoVpdkNXc+EJH1ml7WxkOMhit2kUotO2c+/SQmL8pD0ewMkpO0tZ+KwGPu1
         Wt1fbNGCPad4uhlBPUOOs+7Lk3wPHxR8tpCngWyhrTMdJqVb3MF1kYnZBw2sBnbidu2F
         vEoa7HgKhK4vJmRsaUu2+B6SXzZAzhoN17lmAfS54PUQcpPNGY/yWl3dy81U0plyt4SX
         13/7rPJKuM4fD1h+5HUA3cxCvZPGnJsUFl3RYsxWwDkt+DIVy0V0kLtCCPEOCmxwlStv
         PkLg==
X-Forwarded-Encrypted: i=1; AKwUvByk/jErB2LBe8Z/ZmlkX1D7Th2yaGO5A86K2AesxrcrdyVW/02NZb6CXlqec1FLle7tdqjVkh3behpnz/O+@vger.kernel.org
X-Gm-Message-State: AFq9FYK3A+KEptZiYccQcRm5jgOUqK8njVnMTE6lg73/VO4h6y6OGaKt
	1EYOgRzLsaJo5z7A01Glaws7kqe54drjZ+0bLkuDvbY/B/9ndEw/oJoD
X-Gm-Gg: AYBFou20HnD2tJzojGJtWbsdPktEBCZA6j6Ip/F8QN6aSHwwzTlYTBC0dRvl0+vM/2z
	UY0Ej+3kD0eN7LFI/3hKUpGbRjLkXwpBfT29VEcTJ867mUaPsonrd2dRcNByD9r9Hvxcy/H58NW
	uiTjBNxy11YkCBJcS9i+KgPpm3FkRcrntkbHWYxwc4tHHxqlcv1dTLvcG1GDA3miUfyiF5uWiHK
	zw1E45OL4OWa5Eg9o3sgCllrpoSYPjAZto4Dsfseglmy1MDFw85eiSCEXiMLRTScZp9tozWYKlb
	X2uljO328KY0T06Hfruy9n7LvlG0BwvvT36eBGJ5fzQq+gtwCkeHan9o7vhjdrazIWIMx0Hh8Dd
	nA3BF8VY4KrHb9ChFtJS5G3CLlwQS0fq4CGRFMMgii3gdPsiqWthwWhI7tbUpR3ZynjtBwPwhLa
	HuEu26FpPCHev5e0+pDeGQm1BpGpZiBVVeDmU5r/5acYUdfNgSuBHQbf8mdNqv6aVreDbH4xw6r
	QKlgt7gT1cj1U7hSbMoFVhYXMkainIEsCqGjR476AiExjui/BKdgWb8Alahzks0d0GZOb6fXcdn
	yNh0HISdBeh1SDFJqD5MK1eisJt0
X-Received: by 2002:a05:600c:19ca:b0:4a2:397:73f6 with SMTP id 5b1f17b1804b1-4a211c8fa81mr31321535e9.8.1792754963632;
        Fri, 23 Oct 2026 04:29:23 -0700 (PDT)
Received: from DESKTOP-IR7J1S9.localdomain ([105.98.0.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a21534a306sm25672665e9.0.2026.10.23.04.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:29:22 -0700 (PDT)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: ranhongyun1@huawei.com
Cc: a.hindborg@kernel.org,
	brauner@kernel.org,
	chengzhihao1@huawei.com,
	drifabdelmalekmohamedsaid@gmail.com,
	jack@suse.cz,
	leitao@debian.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	yangerkun@huawei.com,
	yi.zhang@huawei.com
Subject: Re: [PATCH] configfs: fix use-after-free in configfs_symlink() racing with rmdir()
Date: Fri, 23 Oct 2026 12:29:20 +0100
Message-ID: <20261023112920.188-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023092541.1858529-1-ranhongyun1@huawei.com>
References: <20261023092541.1858529-1-ranhongyun1@huawei.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ran,

Thanks for reviewing the patch.

There is an earlier unhash inside configfs_detach_group(child):
it calls configfs_detach_item(child), which calls
configfs_remove_dir(child). On successful simple_rmdir(),
configfs_remove_dir() calls d_drop(child) while the child's inode
lock is still held, before the later d_delete(child).

Once configfs_rmdir() proceeds to detachment, both branches reach
configfs_remove_dir():

  CONFIGFS_USET_DIR:
    configfs_detach_group(dentry)
      configfs_detach_item(dentry)
        configfs_remove_dir(dentry)

  Otherwise:
    configfs_detach_item(dentry)
      configfs_remove_dir(dentry)

For default children, detach_groups() acquires each child's inode
lock before following that same call chain.

However, d_drop() is conditional: if simple_rmdir() fails,
configfs_remove_dir() skips it. In that case, the hash check alone
does not cover the window you described. detach_groups() still sets
S_DEAD before releasing the child's inode lock, so I plan to add
an IS_DEADDIR(dir) check after relocking and before reacquiring
parent_item. That covers this alternative path without accessing
the potentially freed item.

The reference handling in my patch remains necessary: put
parent_item and set it to NULL before inode_unlock(), then obtain
it again after relocking and validating the directory. The new
failure path will release the target references via out_put_target.

I also noticed that your patch's new goto out_put still calls
config_item_put(parent_item), although its containing object may
already have been freed. It also bypasses the puts for target_sd
and target_item after a successful get_target(). Additionally, the
existing get_target() failure path still puts the stale parent.

I will include the dead-directory check in v2 and validate the
updated patch.

Thanks,
Drif
