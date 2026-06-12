Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909EB3655C5;
	Fri, 12 Jun 2026 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277172; cv=none; b=GQ2jWQctn39oQg4sBogU5AyaifY8R5AkU9bhhVQBs9ZNAV2FZC048WUB9bmY4dE7Vpa8HztuIpl1sad8wiLS+qcwsDaEleBzbf4I+vz2LZUgIr4H1BAhmQS3QCZx1qzxKu3NshFMgFqpLdqMoHUdkxBpFMrN2n2ySuvphVT+t4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277172; c=relaxed/simple;
	bh=Clp4ED+5wqKFUtgGc56o8ButsCmqTZzary5sIDI8ijg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubM441/NhontYtyX9BRVhe+0ZSNjX4Gv870SvmHk38yZSMSSESIuI4kTsU0t28GsuPflGa480h1mw6gsNBCdBNvVLaNo27BfaJ6BvAYkm5dbrfuMpmw5bQVKvrdUJo/NbxsABrLJazqiPiCRd0OXtFgimHXI2Pxk5PnJ2E/a9/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RU1lxwLk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RU1lxwLk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6FA1F000E9;
	Fri, 12 Jun 2026 15:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781277171;
	bh=PJJ0u2h1e+49Nljm26XX63GkPnC0vWqst/3z/ordYDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RU1lxwLk2Mbx8I8/Y/GpfCPZ2mKzCOlzC5pdZEQGxCUrE3yEmnTyjfoVTMM06d9KJ
	 airTQg5f6E9mli4S7NOxNRwqDzUrACAf/jOeiSf+De1i7nrTfX9aibKzb4zYpU9+DF
	 U+cIWt+AMxY/AyXvwfnz4HF8mJeIXiROF3fyQwDSiiwEZKuPalkCsEOaUYdBHilCqQ
	 5aAwPCVcbzgkVNsVU3XdcoxqZrRqE5XbEG13heQSnwbEGEWyPiLK9yU9OJtEwPUx/+
	 DOZXPwio3w6ibAlQNbQeQ50iIQih6ozOxtkvLl7RI1Fnx12C2SINHAQpQc5ImaSiL6
	 xuZA1X4bn/Cyg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 05/16 for v7.2] vfs casefold
Date: Fri, 12 Jun 2026 17:12:45 +0200
Message-ID: <20260612-vfs-casefold-v72-e9b33c432ef3@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612-vfs-v72-20facee87e19@brauner>
References: <20260612-vfs-v72-20facee87e19@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8161; i=brauner@kernel.org; h=from:subject:message-id; bh=Clp4ED+5wqKFUtgGc56o8ButsCmqTZzary5sIDI8ijg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTpKL7vung0aG7ipx39fN9/L5POePG15qWqW8/HOSsy7 5w7XNDD21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRt3sY/mk3maZ9l/u24dGh OOX+8+tvn946yVTtyok5LFpbzggw7TnH8N/f5Kwjs2mnYlMqS1qWFdP1Az+6l6z6Nyt16k2ZOze tbzEDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This exposes the case folding behavior of local filesystems so that
file servers - nfsd, ksmbd, and user space file servers - can report
the actual behavior to clients instead of guessing.

Filesystems report case-insensitive and case-nonpreserving behavior
via new file_kattr flags in their fileattr_get implementations. fat,
exfat, ntfs3, hfs, hfsplus, xfs, cifs, nfs, vboxsf, and isofs are
wired up; local filesystems not explicitly handled default to the
usual POSIX behavior of case-sensitive and case-preserving. nfsd uses
this to report case folding via NFSv3 PATHCONF and to implement the
NFSv4 FATTR4_CASE_INSENSITIVE and FATTR4_CASE_PRESERVING attributes -
both have been part of the NFS protocols for decades to support
clients on non-POSIX systems - and ksmbd reports it via
FS_ATTRIBUTE_INFORMATION. Exposing the information through the
fileattr uapi covers user space file servers.

The immediate motivation is interoperability: Windows NFS clients
hard-require servers to report case-insensitivity for Win32
applications to work correctly, and a client that knows the server is
case-insensitive can avoid issuing multiple LOOKUP/READDIR requests
searching for case variants. The Linux NFS client already grew
support for case-insensitive shares years ago in support of the
Hammerspace NFS server - negative dentry caching must be disabled (a
lookup for "FILE.TXT" failing must not cache a negative entry when
"file.txt" exists) and directory change invalidation must drop cached
case-folded name variants. Such servers often operate in
multi-protocol environments where a single file service instance
caters to both NFS and SMB clients, and nfsd needs to report case
folding properly to participate as a first-class citizen there.

A follow-up series brings fixes for the initial work: the nfsd
case-info probe now uses kernel credentials, maps -ESTALE to
NFS3ERR_STALE, and has its cost capped across READDIR entries; the
nfs client avoids transiently zeroed case capability bits during the
probe and skips the pathconf probe when neither field is consumed;
the FS_CASEFOLD_FL semantics are clarified in the UAPI header; and
the tools UAPI headers are synced.

Note that the nfsd tree is based on a merge of this branch so these
changes may also reach you through the nfsd pull request.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

This has a merge conflict with the ntfs3 tree in fs/ntfs3/file.c,
fs/ntfs3/namei.c, and fs/ntfs3/ntfs_fs.h between commit eeb7b37b9700f
("ntfs3: Implement fileattr_get for case sensitivity") from this tree
and commit 245bbdd2b9d65 ("fs/ntfs3: add fileattr support") from the
ntfs3 tree. Reported with resolution in [1].

[1]: https://lore.kernel.org/linux-next/ahmF4spkQMYcQMGI@sirena.org.uk

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.2-rc1.casefold

for you to fetch changes up to ea3120fd5153c967efb20e6e3330caecbf9d8b0a:

  Merge patch series "Casefold Fixes" (2026-05-15 17:49:29 +0200)

----------------------------------------------------------------
vfs-7.2-rc1.casefold

Please consider pulling these changes from the signed vfs-7.2-rc1.casefold tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (2):
      Merge patch series "Exposing case folding behavior"
      Merge patch series "Casefold Fixes"

Chuck Lever (22):
      fs: Move file_kattr initialization to callers
      fs: Add case sensitivity flags to file_kattr
      fat: Implement fileattr_get for case sensitivity
      exfat: Implement fileattr_get for case sensitivity
      ntfs3: Implement fileattr_get for case sensitivity
      hfs: Implement fileattr_get for case sensitivity
      hfsplus: Report case sensitivity in fileattr_get
      xfs: Report case sensitivity in fileattr_get
      cifs: Implement fileattr_get for case sensitivity
      nfs: Implement fileattr_get for case sensitivity
      vboxsf: Implement fileattr_get for case sensitivity
      isofs: Implement fileattr_get for case sensitivity
      nfsd: Report export case-folding via NFSv3 PATHCONF
      nfsd: Implement NFSv4 FATTR4_CASE_INSENSITIVE and FATTR4_CASE_PRESERVING
      ksmbd: Report filesystem case sensitivity via FS_ATTRIBUTE_INFORMATION
      tools headers UAPI: Sync case-sensitivity flags from linux/fs.h
      nfs: Avoid transient zeroed case capability bits during probe
      nfs: Skip pathconf probe when neither field is consumed
      fs: Clarify FS_CASEFOLD_FL semantics in UAPI header
      nfsd: Use kernel credentials for case-info probe
      nfsd: Map -ESTALE from case probe to NFS3ERR_STALE
      nfsd: Cap case-folding probe cost across READDIR entries

 fs/exfat/exfat_fs.h                             |  2 +
 fs/exfat/file.c                                 | 18 ++++-
 fs/exfat/namei.c                                |  1 +
 fs/fat/fat.h                                    |  3 +
 fs/fat/file.c                                   | 36 +++++++++
 fs/fat/namei_msdos.c                            |  1 +
 fs/fat/namei_vfat.c                             |  1 +
 fs/file_attr.c                                  | 16 ++--
 fs/hfs/dir.c                                    |  1 +
 fs/hfs/hfs_fs.h                                 |  2 +
 fs/hfs/inode.c                                  | 14 ++++
 fs/hfsplus/inode.c                              | 16 +++-
 fs/isofs/dir.c                                  | 16 ++++
 fs/isofs/isofs.h                                |  3 +
 fs/nfs/client.c                                 | 32 +++++---
 fs/nfs/inode.c                                  | 15 ++++
 fs/nfs/internal.h                               |  3 +
 fs/nfs/namespace.c                              |  2 +
 fs/nfs/nfs3proc.c                               |  2 +
 fs/nfs/nfs3xdr.c                                |  7 +-
 fs/nfs/nfs4proc.c                               | 10 ++-
 fs/nfs/proc.c                                   |  3 +
 fs/nfs/symlink.c                                |  3 +
 fs/nfsd/nfs3proc.c                              | 39 ++++++++--
 fs/nfsd/nfs4xdr.c                               | 99 +++++++++++++++++++++++--
 fs/nfsd/vfs.c                                   | 86 +++++++++++++++++++++
 fs/nfsd/vfs.h                                   |  3 +
 fs/nfsd/xdr3.h                                  |  4 +-
 fs/nfsd/xdr4.h                                  | 14 ++++
 fs/ntfs3/file.c                                 | 29 ++++++++
 fs/ntfs3/namei.c                                |  1 +
 fs/ntfs3/ntfs_fs.h                              |  1 +
 fs/smb/client/cifsfs.c                          | 53 +++++++++++++
 fs/smb/client/cifsfs.h                          |  3 +
 fs/smb/client/namespace.c                       |  1 +
 fs/smb/server/smb2pdu.c                         | 30 ++++++--
 fs/vboxsf/dir.c                                 |  1 +
 fs/vboxsf/file.c                                |  6 +-
 fs/vboxsf/super.c                               |  7 ++
 fs/vboxsf/utils.c                               | 30 ++++++++
 fs/vboxsf/vfsmod.h                              |  6 ++
 fs/xfs/libxfs/xfs_inode_util.c                  |  2 +
 fs/xfs/xfs_ioctl.c                              | 22 +++++-
 include/linux/fileattr.h                        |  3 +-
 include/linux/nfs_fs_sb.h                       |  2 +-
 include/linux/nfs_xdr.h                         |  2 +
 include/uapi/linux/fs.h                         | 18 ++++-
 tools/perf/trace/beauty/include/uapi/linux/fs.h |  7 ++
 48 files changed, 618 insertions(+), 58 deletions(-)
