Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530283;
	b=p8oBT+pXGNVl/kgpxEIYodKSlqFHfBuMzM7eV+oYdaJcnsENrl9aZPZHGnUHPrArGLxV
	 p0v0CW6O+gJjmXEOD8vdfbaNKK2fMHH9Od58ErRRrmhvG2Q2s8I2jbNTBFd1QunqM9vRa
	 QLVt678cXdTWxcpXTHv4mfubjbStBGd6Ri7WdrNoi/b5qm0S5HzLndlQojBlCHK7u3oBx
	 PXP/4riekVUQWqJlp6scj8lIluWcTJwsUl564MXSItP1rlCSnJPaN2lneuJ/qFkR4lweP
	 OJxZ0nUNxFk11nztx1iS8Xj9aRR43rOFO+vWAa2ieNARb0/d7/BkKLwzOV82gv1EvdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zGnrGgV51ZfRMc1cSUcC07752LjxuuaOfMYKT2Lu9s8=;
	b=IQDbot7ZbgZFy/r45W6B6lITH6qlCB12kR+NF9EY8Qunq5rE+8IpIR2iJkxviGhoypz7
	 hGTTVs1ybUv106O6X1HOLG/utgeaU+VDYF1mIvpu6RcztMU/CY3MlQ2b9t9vvXPwjypzd
	 Jy7iuBpeD7XY3+I7sYG85Fc/0USWpGPAEcQT63nhcaIbOtCvpw+uWSRhb2gtpky0HxFSi
	 e6bR7AOe4gJ/n0MMTSJjCTNl4aWYqoj10qyI3z9EDudWHXq/l7HOhSuWiJLE2olyKRQd1
	 aQ01MBpoM3LBQpaiX1hGWAo9f6VgeTgxKjXCi5G3CKtf0iBWDExOx1qbDXfTCO62w0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Qt7xbgCD;
	arc=none smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A72606A894
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 00:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0A72606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Qt7xbgCD
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67c02c106e6so356597d50.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 16:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794530281; x=1795135081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zGnrGgV51ZfRMc1cSUcC07752LjxuuaOfMYKT2Lu9s8=;
        b=Qt7xbgCDk5woTD8moFfnVvQd9sauI3GkWJN2k2jEW5l/VflCusDJZVhOTjuK2q+rz9
         7DQa10YnplDxPU1v9zOsbvXfA6MCxHOLGYRW6+7xNy7lqVhk+1AhNa870T/BuRXxuEH3
         AmxpO1FsnfCgv3H/zsn3WUyc+hKomwTsesF2zwbp25vFP8HdiZN8L7qakQ0O3/aYAZb9
         shj7JedViV3ddSQBGhsJ8e8D90JayGu43JjL+DafbhbU2AGiSpj6gIWlnFDgWlE7cL/H
         7cObd++RV2ZFogp3t1kfPMjug1WJKOypnFgoyiWnYkp1zsvwRFMD0tmC2copeDSmv9kb
         AKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794530281; x=1795135081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zGnrGgV51ZfRMc1cSUcC07752LjxuuaOfMYKT2Lu9s8=;
        b=lHx/Ajd17gYdX6GBmjDNkiA+nE9MPYgAxOx2EWGZ5opwm5BRqXLCLaChBsGzcztuYb
         Be94IJ0iSnz5r4ksMJ57jfvtIo7wew0uL+0fvIMh/j3otrB/Lsbk0V/J9OcRvevRlmd4
         1vLs4b6WM2RQWANcN7HXM43TuV/veHCm34Q2DpOOT7Kx1ry5U3+Dvuf5zg2XBGiqGl2U
         Jzk8fOPqJj18hGhJatJ6EDISgjxFkMRmsEl9JOIuQAm/L1ogxb7DAkdbinp4g8oO5rmV
         IpRrhjwCyURw2XwREuau5bOLxrHmZeHnBrrTDhdZgCiFZ14/b9Tw4SAViF/9j+T/KnEo
         JCMg==
X-Gm-Message-State: APuU4Z9/Bl84o3CtvTRIFbCr+eNbxeYGTeTuhlS8oLs1LVrs6VYL2MoW
	mPNCh0jNP2XYsTa1j38GI/YVAlrI9dHIsJj7AJhI6mymtOH0lsBPK3paOd4XX23lKN0=
X-Gm-Gg: AYBFou1GKGMELAZuXtn1brgPNFtNBGun+Bg1J1czFEFUqCASz2oZ5VGrxkO003sIdfb
	RlCO+V2r5bTGi3LxjvVPYDFQszomuW7nCaz5N6Luh1E0a7QxJKZn0+8jq0VeWf8qoTnH7rvm2KK
	j8wmNBiT6vh8GDIE+TgG5+E9b+sEaAZW/UOvzTk7hySRnlov+en5bgcH+cgyEw0wtkqNzJQ+qhD
	LcZ14KzSoZLahuEqIlx3Ww1SndR2NWPNAWk3DT9xgEnlEJakbexZZARSyn4EqX7aCNuZ7u5o3fU
	9R/8m6BFQNJhADV5slFxGcCSQy4I+GCERnCZqQhf3XL4AaSlsA+GA7GP/9fbR0ERlLcfJtPZ2ll
	AIl1Cn9jJRGIbAFbvq5JpcxF5fz+iObAuDdRuuoI8c1wlEIZrdnUa4MgwYrdnboBHqWiWNtOWwG
	IXn1B+N+ieH1XiDgvjcyus1VLEskTEVzoUtH77JgDvYF4yQYzJkRe9vxQQi/Xwtbka7ve/ADXGx
	xiu8Cq2kn8mCM50+GKKExUhjzrmGH2YY3d4xRYG8pYkcOF1MBlJqCOYqxN2xkzsk0Ta3MbO6Bp4
	r1FykRwUELwDTojFv4vWDJP6PgSQoLSc7I6wv6v/iIgqVO9/H6L3t2w+e8yvtV+7JIGU6+PaGtM
	FrTx/+KHR/RJoDa1ZPJt89mr72NLNcIvU96Vvz0UdIQaNLXRhwWbEotUkg7fUGklruuxL4oA=
X-Received: by 2002:a05:690e:47c8:10b0:67c:1c81:fe46 with SMTP id 956f58d0204a3-67d898314c5mr465618d50.91.1794530281004;
        Thu, 12 Nov 2026 16:38:01 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:3a31:6c95:5610:70f6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a59e70asm706463d50.10.2026.11.12.16.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:38:00 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 0/2] hfs/hfsplus: don't take inode_lock in ->fsync()
Date: Thu, 12 Nov 2026 16:37:54 -0800
Message-ID: <20261113003756.1066989-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.53.0
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

Both hfs_file_fsync() and hfsplus_file_fsync() take inode_lock()
around the metadata part of fsync. For both file systems
it is not needed: the inode's metadata is written by
the same ->write_inode() path that the flusher threads use
without inode_lock, the b-tree records are updated under the b-tree
locks, and the b-tree, bitmap and MDB/volume header flushes are
per-superblock and serialized by their own locks (mdb_lock in HFS,
vh_mutex/alloc_mutex in HFS+). The lock only holds off writers of the
file for the whole duration of the metadata and device cache flushes.

Drop inode_lock()/inode_unlock() from both ->fsync()
handlers. Patch 1 is for HFS+, patch 2 does the same for HFS.

Viacheslav Dubeyko (2):
  hfsplus: don't take inode_lock in hfsplus_file_fsync()
  hfs: don't take inode_lock in hfs_file_fsync()

 fs/hfs/inode.c     | 2 --
 fs/hfsplus/inode.c | 3 ---
 2 files changed, 5 deletions(-)

-- 
2.53.0

