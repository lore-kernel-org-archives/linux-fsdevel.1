Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788CE35DA41
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789645761; cv=none; b=SyoE2Bp/w+3l89BJfvx4WZo3y4Ym7QLOgJMPwpix7itfb15RUqQYsHAHKxz3m0w6FPnR8N278o9rghfANLTugziGYWbh2JBPiB0lOJ5hAcb+pzVDWH5D27VOaBlGEjZtSDraP4aqcRYraXYNaWCQUqE7UP9wJVqtdmlojBO4Lqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789645761; c=relaxed/simple;
	bh=Gs6Gj/4Jt74JeqAJDh+JoR7UbdeGtOfpNe7/uSrLo68=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HYM/ebZrqc/jWEvnqLebpJo4Rs6J9ZdS9lsu+VdE+LAyBqZVeZC0rURf/6plxrpvGAqFKi7UcKgz1fNGJMLFozzAJIVzbKX8Q454jfsVbeCKwn0Si4KML/3hNjZTrJuW6meig2Q2NcC7ZzyWa9Z3uBqE3eOACMaygTBeq8AOaX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikqsW1YW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikqsW1YW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D1E1F000FF;
	Thu, 17 Sep 2026 11:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789645760;
	bh=J3ZIZ/qKrVelEBNP9YMT1TYlLZFDGrvUdK6MBy39Xgg=;
	h=From:Subject:Date:To:Cc;
	b=ikqsW1YWggMJuUPKhdS7fuS/aGAupDls190huv3ebZglr59oro5qpYcQg1VTRcfmt
	 UltELb82ejVbfMV1wAWL/Y8iZVYgz+GcTKUVBXnMvTbCgC7OTFd2f3wpmdkx9Gvp0O
	 A/060v4+IQBIlzJgDkUCAcZGl/Fs22XKWw0w4P1wKjPQhYQsXeQJE6mbC74T25HtR0
	 89qgS/DdorxvPuvklOY22mKIJMDF8SPzSez0ujUXjfpYZg8jGgsNS0ZKHIVBOKYAXw
	 1kUDbAGxhqjcRSpnybFoJ96fGhwc8KZSLD8dx04dgHaCIvkuvo3ahrkV2pYtBn2Fna
	 DMC7XdjNMYq5g==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] Revert "put_mnt_ns(): leave mounts connected"
Date: Thu, 17 Sep 2026 13:49:02 +0200
Message-Id: <20260917-work-put_mnt_ns-revert-v1-0-34d9b8679e68@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0WMQQrCMBBFr1Jm7YQ0BINeRaQkcWqjmJZMWoXSu
 5vYhcv3+e+twJQCMZybFRItgcMYC7SHBvxg450w3AqDkuooT63B95ieOM25e8XcRcYiUcrofK+
 0bo2WxkORp0R9+PzCl+vOPLsH+Vxr9eEsE7pkox/qVLvi3xV7V9QXbNsXOs+VhKgAAAA=
X-Change-ID: 20260917-work-put_mnt_ns-revert-bcf24417407c
To: linux-fsdevel@vger.kernel.org
Cc: "To: Alexander Viro" <viro@zeniv.linux.org.uk>, 
 "To: Jan Kara" <jack@suse.cz>, "To: Noah Orlando" <Noah.Orlando@deshaw.com>, 
 Michael Vogt <michael@amutable.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2241; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Gs6Gj/4Jt74JeqAJDh+JoR7UbdeGtOfpNe7/uSrLo68=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWStvrwnlIXhgdEdwXvn767pbq58vZHBjrtJfbel3ZYv4
 t+Dp7660VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRj9aMDPf8t5fI/lz9zKxE
 Pdl3xt+ky4z3TZo+et0oWH74y7vfHBIM/0vuMwlV/11ucFZnKeN/t628anPzkt8eP6Rlar9kz12
 775wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Keeping every mount of a dying namespace attached to its parent changes
who owns it. An attached but unmounted mount is owned by its parent: the
parent's final mntput() is what drops the child's reference and takes
its superblock down. Before that commit only the namespace root was in
that position and every other mount dropped its own reference in
namespace_unlock().

That ownership rule turns any reference from a child's superblock back
to one of its ancestors into a cycle. The obvious case is a loop device:

    unshare -m sh -c 'mount -o loop /var/tmp/img /var/tmp/mp'

mount(8) opens the image from inside the new namespace, so the loop
device's backing file pins that namespace's copy of the root mount.
When the namespace dies the loop mount stays attached to that copy and
is owned by it. The copy can't reach zero because the backing file
holds it. The backing file is only put once the ext4 superblock
releases the block device and autoclear runs, and that needs the loop
mount to go first. Nothing breaks the cycle. The superblock, the loop
device and, since the root copy keeps all of its children.

systemd-sysext sets up its loop devices in a private mount namespace and
relies on autoclear when that namespace goes away, which is how this was
found. Anything that holds a file on an ancestor from a mounted
filesystem has the same problem. That includes ecryptfs lower paths,
erofs file-backed mounts, fuse passthrough backing files.

That's a bigger fix and not an -rc change. Revert.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (2):
      Revert "selftests/filesystems: add mntns cleanup test"
      Revert "put_mnt_ns(): leave mounts connected"

 fs/namespace.c                                     |  2 +-
 tools/testing/selftests/Makefile                   |  1 -
 .../selftests/filesystems/mntns_cleanup/.gitignore |  2 -
 .../selftests/filesystems/mntns_cleanup/Makefile   |  6 ---
 .../filesystems/mntns_cleanup/mntns_cleanup_test.c | 58 ----------------------
 5 files changed, 1 insertion(+), 68 deletions(-)
---
base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
change-id: 20260917-work-put_mnt_ns-revert-bcf24417407c

