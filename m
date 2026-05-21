Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4DB286417;
	Thu, 21 May 2026 19:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779390797; cv=none; b=T7H6/my3gxMmg0BlDiVMb7ePUHJsuPRS4NRdJ7A9XR13eTIB7LFvf0DkvDRDqiMChE4Z7tD9/En5cU9MwkO33Z/aOqc43r+AAZAnaxtq2ROdPWifhmCMfQ5UUr9TgSlCl3pWBmwdd4APSZJoYaO+OFP0IcK14Hh9FMkbhgF4h4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779390797; c=relaxed/simple;
	bh=HlZaSTA+iJyVlriQ61bMFfjP8AunR7OWHvt7VAAyPL0=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=tbeQf+JuNlHHleJy0OJEMOJrK+T0jmSza/8tXi1gEvuinHMni8yImCaKjvo8QkDgvcLdkfDfgQwGMFQGUCtlnWFv4Y5yBWH34Ei28btjsCxaKq0ZX/xQN/zy9vCYsSuZWWf2BMjjUuWrgUZJ0FmlHURCpoPippnNA9VTThvIZN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEhm6d9f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEhm6d9f"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1A3CC1F000E9;
	Thu, 21 May 2026 19:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779390796;
	bh=gkCcAcTLCnWUtIWpQSds+dSKx9xuQOKobMVCYNTpYMs=;
	h=Date:Subject:From:To:Cc;
	b=jEhm6d9f4+A+CfS6KJrzuE2rbXdLP8qu4rrh7O6IBLAB3dP6SuNQNCgHc7oiJlcPU
	 AfjI1+icGq6pEYTe5/bawmTJpKyUydBjat/PbK0fENzFRn8qDoxUv6eXOCQH4aihy3
	 wFS7w8Bu4ilGMmi0KvgeUXQefnuLU5VUKXRKUgm4MAsgkuc/J8ieuMRXr5QmZs1Nln
	 rI9oiuBDOWhYQ40ASGULxRqB+hBRoE23Ro8DR0iCu9Pif9LYE0x6JzkYc4+9IMekIB
	 qjkFTQfLt2efQZfuQ55623YJbW81v3QzZq7UxhD+e7g/qhvqP1yYV5mvhutO/G9vET
	 Q7G7eXWB1c4cQ==
Date: Thu, 21 May 2026 12:13:15 -0700
Subject: [PATCHSET] libfuse: new mount service container fixes (3)
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com, djwong@kernel.org
Cc: neal@gompa.dev, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com
Message-ID: <177939069755.35950.14423543819684584527.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This is a collection of bug fixes, codechecker, cppcheck cleanups for
the new fuse service container code.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D
---
Commits in this patchset:
 * mount_service: rename IGNORE_MTAB and constify it
 * mount.fuse: constify arguments to try_service_main
 * mount_service: fix null pointer deref in mount_service_init
 * mount/fuse_service: replace strcpy calls with memcpy
---
 lib/fuse_service.c   |   16 +++++++++-------
 util/mount.fuse.c    |    5 +++--
 util/mount_service.c |   43 +++++++++++++++++++++++++++++--------------
 3 files changed, 41 insertions(+), 23 deletions(-)

