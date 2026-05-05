Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A382239E9B;
	Tue,  5 May 2026 05:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958600; cv=none; b=e1J5bW4IKD/PB6iNqr7uexdVwqNI6NIktARx+C9i4MZKrsWhT8SZZcUoaf7ZrwNgz6PYYnwyodfn1fTd0Nf2nWMkBXe1SPxTEV/hYZ/1FkZSQRbxazXOdmOu52JczRJ8vL35ohClKi5gY1p7xX86SXopbEi2IB45bJft74g1Q4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958600; c=relaxed/simple;
	bh=W0fwXI5996HgyxPDAtnHHFKt8H5a+Vcg5W6rN5xBkBo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tfn+ccFCkhNPVwd15HHkB77W85TTPwa8q0rb18kV/2ik3g/Nh0eZ0pL4t5AZY23cdHJK5mVWpdt7QH7MQCn6zCYDpsImITNMMISF+5P8xxTX19YmmJsNteGVZhSYGn5kEsOzXjBUBmnE00UeJEpHxPYCek43KDyy22X1Y1cE+3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnni+C+/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnni+C+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295B4C2BCB4;
	Tue,  5 May 2026 05:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777958600;
	bh=W0fwXI5996HgyxPDAtnHHFKt8H5a+Vcg5W6rN5xBkBo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=lnni+C+/gRfH2gxebg8DV80xZHAbViGXRDBziHiaZkZbbEQaNiscZ/UKCBos6Z0Yz
	 12mv/rD4/eG3dbM2AtRDdpvKUuDStdz1S507ezVQsSXmvZQvnPcWcsQcn/nevH91J5
	 2SZfoylUyFZrOR9rMJLwVoaOOV/DgmL+AzMHf/71/d3YJ+KoHrmWcILoOMULuGQqwF
	 DamMz2uU30gbAIulkzEq5Kraawrx1Q7jO/VBjb4s+r6fkYSZ4olhRRBRaZWxZg7mlj
	 TAhDHNX2Hx4DraA7cLexnQUfq1s4cpUG40GoczYxBHn6zRr91DoTiSO/KkP57VdUEX
	 Vr40wd3vr/4yg==
Date: Mon, 04 May 2026 22:23:19 -0700
Subject: [PATCHSET 2/2] libfuse: new mount service container fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Message-ID: <177795853647.1133612.5178638086120838710.stgit@frogsfrogsfrogs>
In-Reply-To: <20260505052133.GR7765@frogsfrogsfrogs>
References: <20260505052133.GR7765@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This is a collection of bug fixes and cppcheck cleanups for the new fuse
service container code.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D
---
Commits in this patchset:
 * util/mount.fuse.c: loop in waitpid
 * fuse_service: handle weird behavior during SCM_RIGHTS fd transfers
 * examples: improve documentation of the new systemd service fuse servers
 * example/single_file: sync backing fd when statx wants us to fsync
 * example/single_file: fix ctime handling
 * libfuse: fix cppcheck complaints about constifying pointers
 * libfuse: fix cppcheck complaints about constifying pointers in user-visible ABI
 * util: fix cppcheck complaints about constifying pointers
 * fuser_conf: fix cppcheck complaints
 * example: fix cppcheck complaints about constifying pointers
---
 example/single_file.h   |    6 +++-
 include/fuse_service.h  |   18 ++++++-----
 example/service_hl.c    |   20 +++++++++++-
 example/service_ll.c    |   20 +++++++++++-
 example/single_file.c   |   31 ++++++++++++++++---
 lib/fuse_service.c      |   76 ++++++++++++++++++++++++++++++++---------------
 lib/fuse_service_stub.c |   17 ++++++-----
 util/fuser_conf.c       |    9 +++---
 util/fuservicemount.c   |    2 +
 util/mount.fuse.c       |    4 ++
 util/mount_service.c    |   68 ++++++++++++++++++++++--------------------
 11 files changed, 183 insertions(+), 88 deletions(-)

