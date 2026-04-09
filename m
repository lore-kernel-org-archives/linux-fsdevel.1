Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A99A2D5925;
	Thu,  9 Apr 2026 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741449; cv=none; b=QzrcsGQeNdkWdHEitvwyAnME66SzQd5wEi3gg62yAPJ33Zu5JDmpp5ZDKTo0ietxA2dV/uHKdeNERMSqtpOo1X6IxSAlPG/foIxFw+KIXI6m8WDoKXx65MkRX0UJCncL3jD7Q82ildC4Z4PqDbtuCicsI0BTlUrEDxDCfGH6caI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741449; c=relaxed/simple;
	bh=2SHQ+Cc3lMU5E9iQ790kdmBxOagbw6Ul4E4i+zQyOVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4tcPzpw3d8H4qF+56ZYwOkJmgnyUgiluWFQQYI+O2U0x5/TYHPQrwV/PefORqLdPSd2tMr5XYDGXf3T83P18P/9qD7NH2ymsYn2N2ZhpL/QXI/HCIdPjCYlFgksQeMHv3StBgR3RlWxBEoQXbzbu7aF1evychpwMbeCVFbuKLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVVAfj96; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVVAfj96"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A107AC2BCB0;
	Thu,  9 Apr 2026 13:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775741448;
	bh=2SHQ+Cc3lMU5E9iQ790kdmBxOagbw6Ul4E4i+zQyOVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GVVAfj96AJbAGuvg1rYPH17zMuc0uKbfIDO/AYywyeXtaRie5mPlj7DHpPvLLj/ly
	 zCKcn5vON/w+ZGdMSKFrD6pJWY3wQ2PRfhCco5ff/hU5mFYGTRwdeVTKOE6XGqd+2X
	 6WYwaD0NklvxxGO+oMtMrw/b6KQk694+ScBUnbjSYojuGJO6JtwXy7ugM7VdBF43HY
	 fXWs1aNz5S/abor6MIj+DkqpPKmcgRBp0JjW2cp5DBp6rPqLoL9Ie80k/TL02Kf2lb
	 4LMlxWhkH6ag6gEMRXmCe7Qc5n1+trmBRDJdCHi745+OsVeai5h0kOSfsaPykHWdFX
	 gYFAXLbhjKDKw==
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <aleksa@amutable.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Aleksa Sarai <cyphar@cyphar.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2 0/4] selftests: openat2: migrate to kselftest harness
Date: Thu,  9 Apr 2026 15:30:32 +0200
Message-ID: <20260409-sorgenfrei-bernstein-2f4f993c490f@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401-openat2-selftests-kunit-v2-0-ad153a07da0c@amutable.com>
References: <20260401-openat2-selftests-kunit-v2-0-ad153a07da0c@amutable.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386; i=brauner@kernel.org; h=from:subject:message-id; bh=2SHQ+Cc3lMU5E9iQ790kdmBxOagbw6Ul4E4i+zQyOVc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWReX8Usplnb++7V7PxL/FM3XZ5RMM/p0pEtgpV18hu95 lokrdy0u6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiujaMDG0bpu+7HrVbm7NF IdY9ZqcOK9vMRcKncn0uR07m/vfvzC9GhkX/Gh4VBMWX/hbM8jm15df+sFW111/y/WF7967oa+h bGy4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 01 Apr 2026 11:28:01 +1100, Aleksa Sarai wrote:
> These tests were written in the early days of selftests' TAP support,
> the more modern kselftest harness is much easier to follow and maintain.
> The actual contents of the tests are unchanged by this change.

Applied to the vfs-7.2.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.2.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.2.misc

[1/4] selftests: move openat2 tests to selftests/filesystems/
      https://git.kernel.org/vfs/vfs/c/4ac6d5007161
[2/4] selftests: openat2: move helpers to header
      https://git.kernel.org/vfs/vfs/c/4bbc575d97eb
[3/4] selftests: openat2: switch from custom ARRAY_LEN to ARRAY_SIZE
      https://git.kernel.org/vfs/vfs/c/20321927da56
[4/4] selftests: openat2: migrate to kselftest harness
      https://git.kernel.org/vfs/vfs/c/1993b7daaf1f
