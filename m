Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795731383;
	b=Oevp3miS8qkrZoi1mQ8KKM0o9kY+i1jfxNCUhpky6lJ0T2qVJ93CeMoGtF+AWXr6o6Tp
	 ytNa2qEwCyaqHNsDtyfMnP+yexiEa3I1Gb3D0qjeLsFcpLzrYCjMc+5feOy4La/GJU1p4
	 GJwoK9TNUDuQQ+9TqDqkqOkwpHRFw1PO13Tc/kKpBAJyPioDOiLtKAYsqkRpm9lKSwf8P
	 IV7HJxBRGGM8HRRKB/LJBXPR3LYCPPuFDFTxib4wL2MjUYR9XulEK5RVj1I/XcnI5wnYU
	 YfPa9+9+VxZgEBFeQAYwlQ6qKLXPgmnakIi+3dksUmVq8hqZq3RyaFwMaZSEMqpn5Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795731383;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=j5IBNz3SIMv2Dt/Xq/+fSGmPcSx2opqGLqLgk+FS9Ao=;
	b=1XR+HUR53rxRvXPufvwf9Bf4Pg/mfWe+upOTWWUNmozvQ4vcndlJEAjIaOzAZliUM5/3
	 3FPyrlMHFptNdA2VIC5jE+70Os+bRCjyDcprmTGiI3KSSkobe+M5v91IDPLanyZ0bioBx
	 v6EaU4h9Q+Hg8nHn01Lj/dHEE/YAvGkwzrHZSi/Ed6cz1ThZfDXnWudwpOOlnjlZRzaOn
	 alkFfEnZHbtmhCgPYJ5wSsoZ+3tFCuS1N+6Eidemea2vZ94ArYlXNufVArRng0KTRDHPc
	 aMQiki6l1RhWPsetH09Fek3PNnKZNv62/1jPGHlGgMDwJBMPwpNaZ1dAA+ytlyiRbUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgXgEncC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AC3606A31C;
	Thu, 26 Nov 2026 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cgXgEncC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6CD1F00896;
	Thu, 26 Nov 2026 22:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795731382;
	bh=j5IBNz3SIMv2Dt/Xq/+fSGmPcSx2opqGLqLgk+FS9Ao=;
	h=From:Subject:Date:To:Cc;
	b=cgXgEncCFSNQcnhVZmKpVo/UiQ1KOnlBH7p4IIglX5Ppf8Jv+3R10hw4tLhJRE4a9
	 4bGeigW1yuvEFdCLQoYvQkI/Fgq5YjDBMiBQVIvk74clHJOJL4X/n8WRhww14BqcVP
	 QNAYt3M1oNWAeX0P+f42ndiCX1vrfz/VhKfOBP5m/yXepdHqMXaaZwWB5UB2k4bpSZ
	 YIIJ7PIfu2YQshKMX5swdoHAXz8PQ2Ec16LE2WomFq3cdQa6OiiDhd8NDjAtwbtjun
	 sEwCxFveobFi7U1BB6LSGCecsOwEoiUyJzpVLrSubzWn8S7JZ/EORszsugYcZJBYJn
	 dDEahS2Z1ogTw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/4] fat: support O_TMPFILE
Date: Thu, 26 Nov 2026 23:15:30 +0100
Message-Id: <20261126-work-fat-tmpfile-v1-0-3bca7b2dbc20@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y3MyQ7CIBCA4Vdp5uwQINpYX8V4YBnsuNAGcEmav
 rugHv9ZvgUyJaYMh26BRE/OPMUaatOBG008E7KvDVrqXind42tKVwymYLnPgW+E0suwHWjY+X2
 A+jYnCvz+ksfTr/PDXsiV5rQLazKhTSa6sY2aKKoo/qJoe1jXD3aOnZecAAAA
X-Change-ID: 20261126-work-fat-tmpfile-0d0f49e95d8f
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=1903; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JWvzku8vn23nXtqkRXaLlGhoF3JlVBHJ63WGEN8laLA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRzrF/b8a4uvlGC9ahWzYo9q03SrJ5PuVF73reBQZXvE
 zMbI/OfjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIls52Jk2BgjuTX5KauB7be9
 S7wCyjW+Ttef/+glx48dyrck07epPGNk2HKnwNXk8bVzjWqhG+e3JzcxvFgneGTD2dXzNxbOfVB
 0kR0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This adds O_TMPFILE support to vfat and msdos.

Currently, every O_TMPFILE open on FAT fails with EOPNOTSUPP and
userspace falls back to creating a named temporary file and renaming it
into place. systemd does that in bootctl when it writes to the ESP.

FAT can do O_TMPFILE just fine. It already handles files without a
directory entry: when an open file is unlinked i_pos is reset to 0,
writing the inode does nothing and the clusters are freed when the
inode is evicted. An O_TMPFILE simply starts out in that state.

The only tricky part is linkat(). FAT has no hard links so I added a
->link() that only gives an O_TMPFILE its first name. Everything else
still fails with EPERM. Adding just ->tmpfile() would've been a
regression. systemd only falls back to the named temporary file if the
O_TMPFILE open fails. If the open succeeds it calls linkat() and gives
up if that fails.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (4):
      fat: add fat_tmpfile()
      fat: support O_TMPFILE on vfat
      fat: support O_TMPFILE on msdos
      selftests/filesystems: add FAT O_TMPFILE tests

 fs/fat/fat.h                                       |   2 +
 fs/fat/inode.c                                     |  31 ++
 fs/fat/namei_msdos.c                               |  70 +++++
 fs/fat/namei_vfat.c                                |  46 +++
 tools/testing/selftests/filesystems/fat/.gitignore |   1 +
 tools/testing/selftests/filesystems/fat/Makefile   |   2 +-
 tools/testing/selftests/filesystems/fat/config     |   1 +
 .../selftests/filesystems/fat/run_fat_tests.sh     |  41 +++
 tools/testing/selftests/filesystems/fat/tmpfile.c  | 324 +++++++++++++++++++++
 9 files changed, 517 insertions(+), 1 deletion(-)
---
base-commit: 2dc60bd9975fc8666a13d58410499e06e6799ba9
change-id: 20261126-work-fat-tmpfile-0d0f49e95d8f

