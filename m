Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E1630DEC7;
	Mon, 26 Jan 2026 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769428639; cv=none; b=YYBrK6SpulqUCfOVLMK4CiekbXu7bD6wIPchmuwamEAEqD5MRX5vG15TpWxJYZ3/VS23ifrKkxh74Lvu73T6CnFVE6HOTPQGx2lRut1skne3RRl9hVg4wZ69SrFXcOTTHIi/rOvxLGL6SPLN8nZABM1wlJfZARe3sKMxF0dWfQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769428639; c=relaxed/simple;
	bh=f5oUh44aQGLvnEnK72BZw6o30+2apqRnoEL5cp2255c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/rD4OqqS//E3wdGyuLzs14DaKFcDNR2fgm9kVTHN4yxbhjybiGngL+RRXlOuybExCB2pyxQiVXLcvxfT8QfihRPsRHhXMGrMlVmewi6KHrjfsfY1jXPQbRHG/RxQ/gLDS8xNeQqqfa+WiNAsnvCq9zwWUdQkKo1s1OnCM1pcmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErH2qtAv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErH2qtAv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60053C116C6;
	Mon, 26 Jan 2026 11:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769428638;
	bh=f5oUh44aQGLvnEnK72BZw6o30+2apqRnoEL5cp2255c=;
	h=From:To:Cc:Subject:Date:From;
	b=ErH2qtAvAqb6+0E1hCcI0tajUSD2MONujMxc370nZaDo1d9uE6loD544gM7RJyB22
	 1fgJNRpCw4C9O3FSVYhXpdve6mOZNw0choqZZ9wRKq8s/cuXdZ5fAxFxa2ilaPC6NP
	 csnncHAth7Cx4VgN3zixr6r6NoCFnhmGUnkxazwI3VY58zIRvAZz1gWIVFt2KITs8C
	 TLXuWWQUcJe5RNIoRio/Z1tunkUupPQMlzBP6lWG8eEfVIAXKuDttbHXzueVw1U61S
	 nBIfjLHSPwOR0I4HcOz/VKrxMi4sVABrtjiwP1DjmC+9Zm98xSLlf5xHA7OmWzSNq4
	 u698jGn3zLyAQ==
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fsverity@lists.linux.dev,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v3 0/2] Add traces and file attributes for fs-verity
Date: Mon, 26 Jan 2026 12:56:56 +0100
Message-ID: <20260126115658.27656-1-aalbersh@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This two small patches grew from fs-verity XFS patchset. I think they're
self-contained improvements which could go without XFS implementation.

Cc: linux-fsdevel@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>

v3:
- Make tracepoints arguments more consistent
- Make tracepoint messages more consistent
v2:
- Update kernel version in the docs to v7.0
- Move trace point before merkle tree block hash check
- Update commit message in patch 2
- Add VERITY to FS_COMMON_FL and FS_XFLAG_COMMON constants
- Fix block index argument in the tree block hash trace point

Andrey Albershteyn (2):
  fs: add FS_XFLAG_VERITY for fs-verity files
  fsverity: add tracepoints

 Documentation/filesystems/fsverity.rst |  16 +++
 MAINTAINERS                            |   1 +
 fs/file_attr.c                         |   4 +
 fs/verity/enable.c                     |   4 +
 fs/verity/fsverity_private.h           |   2 +
 fs/verity/init.c                       |   1 +
 fs/verity/verify.c                     |   9 ++
 include/linux/fileattr.h               |   6 +-
 include/trace/events/fsverity.h        | 146 +++++++++++++++++++++++++
 include/uapi/linux/fs.h                |   1 +
 10 files changed, 187 insertions(+), 3 deletions(-)
 create mode 100644 include/trace/events/fsverity.h

-- 
2.52.0

