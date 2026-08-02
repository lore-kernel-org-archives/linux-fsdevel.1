Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41861242D6C
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Aug 2026 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785709132; cv=pass; b=hEt8tSifkhxqjtmx3Ww6e5W5iHME/bsSVg9eht3dW5kk3/Mtxa7nKFVgzZJIxjzv28fnD/8sD+izx4B0w6oKAsBabhD6x1X8nkx6tDzQbeytAsr0KL/+kMn0L7K4OJOAC1BLytYaVfzHdl5AFo/Td9aM8GmPfzwCGfvJebz8S1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785709132; c=relaxed/simple;
	bh=M7NAjg2xq5AEf0d2aRbxh/Yjava6323xk5fP9H9LQgA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=HOc1TxYOA3jVVnwJYjVGENIgZY7wuswb0lqOSpNNAtSdVaryCgPwYlrtTHdXlnyA1QccoRrKh+0d4/7yKiVpo2cTP711jYVbbRYK89BTVSsTYCboy7srjiZjgd0vkce1ZttZFRFCGMoUhm5Ilki+/KvFy0qhfjgEDPvIf7eCeQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gv7sdFnO; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gv7sdFnO"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-80e24970f1dso18786217b3.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Aug 2026 15:18:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785709130; cv=none;
        d=google.com; s=arc-20260327;
        b=Ou1CLgRuhNwjaDa5gOW7By0JPX5b+tXeaGiL1yf17+hp59UStOrDSGnR2xfCN5+3MV
         G0pO0XwRcElss5mxx2P2ClllVV4k5jEc/lGDOyntZ3hJWrY5P3FxnBXW67+BSVETzxeE
         JoiNpP+zi4DMAVsqv1W3e1tFfbxGWIGBEQdyR6Uj866RE/0dPhZlBdeBsEOjQ3U2pysZ
         rcEVTk8do8XeDM5V3H2StuO8tVG5wTNP/+UJNZa6XRtcSz1c4D67I3y/7vWabD7wLKtg
         yrsZVXP1xecKr8uWvCqp7PqUlo3RpRBtYP9Us2aqLoh+H6GzzB0y8+MMOMthYA4CyjwG
         kdeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=M7NAjg2xq5AEf0d2aRbxh/Yjava6323xk5fP9H9LQgA=;
        fh=2jHlW0lIhibVugyHUGZbPyltjVa/9Tww0kL7USNpICg=;
        b=ELjvIaVRHRW8VHfT5hU1b7jI64/K3DlN/QHP4YYjF0D3xR9lXcpg7qwoesfi95PCj7
         BG/QEKsV9KwnONpbPpou1ktfURhTmxTHqEDrubKtxWv9bPzpw7/0USS3k+hcLkGymfhU
         mKPqMol/FbudE/RlbWAhs9FEPBZZKnw4GtbYZVHg3o3IbohxA6uzAmInRutUyT42zC/G
         w3obTNqtpaYfRON418j+sZRw9K3ydEM5GYcSSo/g+fc6KlAlWgeMEBz5yhy2vS3d7La7
         f6iGQWc+B74afv95/zmOr0XubHGaceVrfAqOZTA7JNr9ENcw77ZNh/Zft9d/4Rmq3HBH
         CBdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785709130; x=1786313930; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M7NAjg2xq5AEf0d2aRbxh/Yjava6323xk5fP9H9LQgA=;
        b=Gv7sdFnOR/pk4b+mlz4nrPK3Lol4QxBIP4oFZucdNY+zyCu8OomOBx+/up4PhXwH6e
         2xosJLrXG+sl5J6odv8OROwQRETCXjhVD6GzGNLLQWTCmDvyw/myNllGdplwg9D020RO
         xGR7e8Z2S846vAYmDk6y/jhkXYqWSjNNri8wn8v4adp6EOuEDnwMy+yY3LEn/GEpLo+J
         f+FsJTpjMTC9y2sawhpwppVJJ+68HH2ZG0XlhCfHIqUZnoe8CqLydM5P789ubqG/yMRg
         BpewD53/2z8rg0wu9xcnU7E+Wj6poSeGwb7KXbdx+joXTlRjjCoGMFiT3He/oYXhAz0I
         oYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785709130; x=1786313930;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M7NAjg2xq5AEf0d2aRbxh/Yjava6323xk5fP9H9LQgA=;
        b=YDVYPOa6S9OQs7KbfCShyoyIppswuM997PmWZYWaHUf+S4yRfgvqVKGhfDNAE3Yhr7
         N/f8nlFdqPRs/Coc8izDj5BThFOGZ6jOVNfDWcL6ZSVBzK1NcKmlZcKdQJ6T3GIrN6tU
         xZEgJNYJ/gSpZt2ZvIwruddXBhUE+z9lVOXitBWAYhml6iv5idjH+YHI45fmk84sNIGG
         HIZc+1uqeZ47B9/1UUzY5Ay3teFWyEGB18gDCxMrH4h41127dWJ6vLqgUBotZW9YUHwo
         Q1VyLt3ux4HmsoOA4RDYV+SF/UNfmqlr3GIcCfREgefq57HkxcMGXWzegkycZzL9hA8I
         wAew==
X-Gm-Message-State: AOJu0YybXpY/ip1LUCjCude7oO+9u0UoBpct2bfNjpg/Nn/sW54YPcLL
	cF4wKZaKGimLmV4kL+sg+LkdNnAhxcdN7v/usfb0PQeyVmeVcRJfIxgB94eQsmQs9UzzQ+a9s2S
	tJLiGB5p1EYC6ie2Phl+CX86dVFFxx8/hvHtp1VU=
X-Gm-Gg: AR+sD13uMKuYaw311/Up1pbzIxeBu3tdElEyKlxTxYUyi8vhMfuzBJ83fBbGpplYAtr
	L3Eqcy471gOz26KxgUrIlD7kBGx01OAf9xEeVnXnbunjlF59ZpDhd5gpi1uJ0xhv7+eNftBM2BB
	HOFIyf5Zqa3rBwCwcXYuIVC3ziEgqEvJcNVNIphOikEVtsMWxaq3ilnHExctAny4LxzaC6BKmmR
	jlcEBz4iifkbr1YIZGNjAtfYY/gQKNfWFXETweGZQLmMWDJqxAMrKqdtIM2HWF0ZSi2OGDd0LLW
	GvcSEhKQGMfjJmWTfVbN8L3P8LVjXySvdMn7xKsvrOvaeiJo3J/fiEfeugmblO7B8bapmKoVhzM
	x
X-Received: by 2002:a05:690c:6903:b0:80b:bc16:8a2a with SMTP id
 00721157ae682-81fd4bf6790mr106571267b3.36.1785709130014; Sun, 02 Aug 2026
 15:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tigran Aivazian <aivazian.tigran@gmail.com>
Date: Sun, 2 Aug 2026 23:18:39 +0100
X-Gm-Features: AUfX_mxpwdBlicOuqO35Pfzvgj_hX4ijadXrcK0ImQgrMK8WB5i-HCusxqGD9go
Message-ID: <CAK+_RLmWU-GjYu9Z+AWnoKd__AiaWZUt=zOkx3jr2-a4Hv3KHg@mail.gmail.com>
Subject: ext4: spurious "orphan cleanup on readonly fs" due to remount,ro
 failing to reset orphan_file structures
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

I have been experimenting with optimising rootfs for custom builds of
Ubuntu 26 with various options like fast_commit, sparse_super2,
orphan_file, inline_data, metadata_csum_seed, etc. And I noticed
something strange: if my root filesystem is made with "orphan_file"
feature then on every reboot I get this message:

EXT4-fs (sda): orphan cleanup on readonly fs

(tested with SSD, NVMe and even old HDD -- because initially I thought
that maybe it was NVMe controller failing to flush its volatile DRAM
cache to the NAND flash, but no, it wasn't the reason)

I think what happens here is that when a filesystem with the
"orphan_file" feature is fully unmounted, ext4_put_super()
successfully clears the "orphan_present" superblock flag AND properly
collapses/resets the physical orphan file headers. However, during a
read-only remount (which systemd must do for / in order to halt the
system) ext4_reconfigure() clears the "orphan_present" superblock flag
but skips resetting the physical orphan file structures. Consequently,
on the next boot (which starts with a read-only mount of /),
ext4_fill_super() observes that while the superblock flag is clear,
the orphan file itself appears non-empty. This unconditionally
triggers ext4_orphan_cleanup(), which prints the spurious warning,
scans the file, finds 0 orphans, and completes silently.

Let's test this theory on the kernel 7.0.0-28-generic of Ubuntu 26:

# 1. Create a filesystem with the orphan_file feature
mkfs.ext4 -O orphan_file /dev/sda

# 2. Mount read-write
mount -o rw /dev/sda /mnt

# 3. Remount read-only (Simulating systemd shutdown)
# This clears the orphan_present flag in the superblock, but leaves
the orphan file structures intact.
mount -o remount,ro /mnt

# 4. Unmount and mount read-only (Simulating the next boot)
umount /mnt
mount -o ro /dev/sda /mnt

Expected result in dmesg: nothing (well, except the usual
mount/remount messages about ordered data mode, etc).

Actual result in dmesg:

EXT4-fs (sda): orphan cleanup on readonly fs

Since this affects the default shutdown path for any modern Linux
distribution using systemd and ext4 with the "orphan_file" feature, it
would be great to get the remount,ro teardown path aligned with the
full unmount teardown path in this aspect.

Kind regards,
Tigran
