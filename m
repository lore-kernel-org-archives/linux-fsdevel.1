Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794974493;
	b=w3IwOEQS0v2vRdO2ajDgb9TcUOZMg6bEHf9dOhbiRA0levyjOejlQZTY/wh1yV3T+AL1
	 QJEud2RJO8yEltIOJ7Q+n0oBHFucs2nGq9IRGFEBUQdcJgIPmMuNy9vgFkz4uFgp91DO/
	 rW9Hp6TB9CZ2E8L8rCnrKL+rT//6NHTSkvsRASsd5ypgtuAN6NwIHVFaAMlJtJ89BmyUg
	 fvcXM6UsguY+fMKT7P5cYEs1fcUjteSvnaYGHDySsxDkDxy7EQoUKkDGiO7tEYcg82SDQ
	 csyEgoXfbkQXcl3KHmYF4M0PfjQpp5PH94L1Oc1cq9SaZK/azWy2ZYtG7jBKrUV6fzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794974493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i8JG/335Ei/T3nsMnFt3EwOc1nsl3qPje8nCv8HP4GM=;
	b=grShc5K6QTZXehVxEf/VvOywp4lGaQxkVvIRJWryCWSeKP0fc7Phnm1LxJDX+QiN1wKv
	 P/OLMqLHSp6pw819aG/jLdImO/4nwMtKNXSxwMJy+VgLESxpDlAQDaLAwxENFx/1wzp0/
	 1iM+opHUDHT+HfjgKOr1ty96ViaCeyvSEnpJfVhd6GxoRdqfaqw9Y0r+m55qJ3iJ6dRIW
	 Jo4SZAEhOnahmni8EIGLFFcSjKCZCA25eMN5pHcQ/lkn8lqihlJuqmWLQEgl+BVZzQ273
	 IWhPS2Lc3nUbMzF+3T/mG+d3nEh2s+MAiiHKbncp9bYbEk2wKWXf5NkQbMf0RyZFsNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p3vuzoUs;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D63D606A325
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 04:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D63D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p3vuzoUs
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so317319a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 20:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794974492; x=1795579292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i8JG/335Ei/T3nsMnFt3EwOc1nsl3qPje8nCv8HP4GM=;
        b=p3vuzoUsVRnTGLL8m7ZG4pi8R4Z9meVqoZ2s7Z6z4AKxrRtFfE9leaJqFLg2UJ+YT4
         WKmt0fq7uOrnwsooz5DfLo+ZW0fH0CqShBofwn4orqQHrPjVN2rEKBSaXL1KWePYbutg
         O4oa95ReLwUxvvpL9hiNYnYu56ugSymeVitdGcvjVSpKM6B0MR169dg98pm0/9k83g7T
         KVU+SuMfhx6ac+2oXUkGmMqzFKwByfr5X1WMe1jLIl8o4ZXalAp0wACNi9xuYvRvNqQb
         KaB8bq3RqcsGGKvFgD6hW31SZyRSFlS4dGqwIEQ2yLfbYZUqOILZMX84G3kp7MIIzoNJ
         jk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794974492; x=1795579292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i8JG/335Ei/T3nsMnFt3EwOc1nsl3qPje8nCv8HP4GM=;
        b=yig/uTy0/kkUJ1j3CxNhFEMzb9+9tpkSFRnZVWio/mA9uPTgQhhU8OPNSqpQMxvIoc
         lblqahdpXXRrNNhuyc9NfCeFrsFFKosocXL0rEXBVavbKFDCf8DYfEg0W3hbfj+jHwzy
         4OD9MYNV/IdMNG0nM3MbV+j+G9llLsthzmQsXw6TSi5OuEEiny0z6ouYcAYTFPXOi2cQ
         9ZZfbdmu2fG067VDE/ux74tywgp1XTgXgQPjzhr1o2XcjRqLOeEcTEmHe7kv+s+gOo9X
         Qjo2HsOFvkGvUhazgBc4lRMnym71FQP8Wnua/S2CBld1GfgXAgWxnF3eT4WZWATn+3B+
         k09w==
X-Forwarded-Encrypted: i=1; AL+hErFR4V8qZw3NhqQLh+er3sf+Pz4qvqudTs5HUKfwfTDmJd4XIlxi8zEcE/L8OcBEBYL/aGd/kRmyONHTxASc@vger.kernel.org
X-Gm-Message-State: APuU4Z9z1JlUgdoUMhlj8dItDzQr1yk3UP3M5YsH8cTxC05VMGj7ViVc
	T97pjmUSa3+fEmzpuymNEinvFzcqzmQbU/gYESPI1KzUk/ZM7OQzvycgtY1Q+A==
X-Gm-Gg: AZFdTZewQHAehKXnkw9JRNMv/ia+c5PxPra3kvdAAEJaojQlPgaBbr/Wvo4o7QShW9i
	vq3E6oGdCZsaYOzpEa5AbTixSjV1JgwZdfrjCEFEaKtBcnWIdUKNaJfHrVutOe7lCc06Uy84yU6
	P7lHge3CWn2Xt7Vq3/IYdHY7b3G+w03JQ55KnG/GXznsD7FINalPkqGsoHRxzKISgr+JKGUFHt/
	p6SRLVmES/z0TLwkiMkhgI3ifSr7u21CSynbsPAT57ji+JcpXYiWNhmkHs/tPMnIpxklnFdvIBg
	m9JjO5EkKcKyIaZhMLspSuBop2XzyoK+RgqKEwFZafBH4D9l7pPkuclXHJDTlxgBg2lAEWroKi9
	hzDJaWl0Bh8pyoWd7aeOM8/lWGj6Q1RVVI0xga0u1/ARlt3DlwDwxSTlGtW+zCVpHDxZjpc9Wbc
	pZCBEEFp80+10hGNhAIkUkjSxzZRtqeH/LE0+XC2p62uX7nQvfe6pqhRqVF1d9duVwFG8FNQOeJ
	EvCWdZ485yKIiOnduPAhc5hsNUR5UVcS4c7+tKE0n01vfI6JjYN1se1b1cUGFsTp2gBPdoxz9qc
	oUqEnWxhoKBD8Pi/QYYIYlyiIJPuO0y5NQAeSEUqurXy+j/BN12m8VfvM1yx0WjA2g==
X-Received: by 2002:a17:90b:3892:b0:3aa:6b5d:a00a with SMTP id 98e67ed59e1d1-3b3d07c2484mr1499748a91.53.1794974492310;
        Tue, 17 Nov 2026 20:01:32 -0800 (PST)
Received: from MacBook-Pro-8.lan ([27.125.146.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d5689adasm580542a91.1.2026.11.17.20.01.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 20:01:31 -0800 (PST)
From: Ding Feng <dingf3ng@gmail.com>
To: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: ovl: sync_file_range() does nothing on overlayfs files
Date: Wed, 18 Nov 2026 12:00:56 +0800
Message-ID: <20261118040056.6543-1-dingf3ng@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Hi,

sync_file_range(2) acts on file->f_mapping. For an overlayfs file that
is the overlay inode's mapping, which holds no pages: the data sits in
the real file's page cache. So on an overlayfs file the call writes and
waits on nothing and returns 0.

On a Docker overlayfs root (6.10.14): write 64 MiB to a file, then call

  sync_file_range(fd, 0, 0, SYNC_FILE_RANGE_WAIT_BEFORE |
                            SYNC_FILE_RANGE_WRITE |
                            SYNC_FILE_RANGE_WAIT_AFTER);

Dirty in /proc/meminfo stays 64 MiB higher until fsync(). The same
program on ext4 sees Dirty drop by 64 MiB after the call. Mainline
fs/sync.c still takes file->f_mapping.

Amir posted a fix in 2018 [1]. Miklos preferred to leave it [2], and
Dave pointed out that the call used WB_SYNC_NONE and so guaranteed
nothing. Since commit c553ea4fdf27 ("fs/sync.c: sync_file_range(2) may
use WB_SYNC_ALL writeback"), the full write-and-wait form does
data-integrity writeback on other filesystems, so on overlayfs it now
silently skips what it does elsewhere.

cachestat() has the same cause, and Pavel's series in June [3] fixes it
by forwarding to the real file, as ovl_fadvise() does. Christian
suggested a helper in fs/backing-file.c for that instead of a new file
operation. Could sync_file_range() use the same helper? I can send a
patch along those lines if that direction is acceptable.

I found this while checking sync_file_range() against its man page
with an AI-assisted verification tool, and reproduced it as above.

[1] https://lore.kernel.org/linux-fsdevel/1535300717-26686-7-git-send-email-amir73il@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/CAJfpegv50HELSZuwt9gGjgSyB+4aPbiTncc-yBNqUVgTLNHaXw@mail.gmail.com/
[3] https://lore.kernel.org/linux-fsdevel/?q=%22ovl%3A+make+cachestat%28%29+work%22

Thanks,
Ding Feng
