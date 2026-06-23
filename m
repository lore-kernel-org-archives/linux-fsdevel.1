Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231BF36F8E7;
	Tue, 23 Jun 2026 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209592; cv=none; b=soHr7r6EnlpQQX/eqQKWwL2kPCp7eWSrfS2ixOFU+t13ZXYyfUDxSoc8GTbtdqDJ01qYNG97ATekUK1YfCrEoPlyugrbLIcxFTOlswpa0DPoyXaeMXgylvr9n4pApxxAPr5le3MC2rHjqlRNtQm4GkpAQ6AEHbu2S1OVVgS2T88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209592; c=relaxed/simple;
	bh=XwTPIE05CmJRQWmA5uydOicG/inBuJ0Nzsm7ufk8+FE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C0DTLvfUxBACtLp/4kWOCQS9QBMc4yv/HXMJsKhPdFFNgBaMJ7kah2lIclhgylgMuEkDZpvjQKi2Yr2sYM84/2X4vY4JzsHGBQS2IZLuNuYuvZf+TdfSYgxsbzFk86wR0Ht/ztuieiq0S5RaP4w8H/ZYFOQGl1fXgHyvkElvHr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3h60Os7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3h60Os7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602291F000E9;
	Tue, 23 Jun 2026 10:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782209590;
	bh=xpo3o0DLB4kD0lnZK1OKai4UpyhZBVTF86TaRfg9oV0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Z3h60Os71JyCpl6/6/87JV8wMLs3RRzdPkmIM25Zhw5bqjPLdR4krZAgl5DzldkX6
	 RmGu0T4PQxQTQ0xgQK1btciQZBog6f5gDK6BYNQXJ4Wp7LUCX3UII0aoaSSZUb6hU5
	 7hsoF94lPmpAL4dDz2jt2wFoGl92oWIJALg+d/E9q7QUFYf69mN2FXXnKj9KZ78QcJ
	 pnX+1I3kzLOKBiXfMS412TqpZr0XK+/BdxLWKDT+lHLm4fP01Ppzu/qTCoprpQF5U8
	 0lUKd7S4VGQE9yspy66jp53TU00X6uotgovf6kqf/NWf1vPGAZjG4qTwNpuFoaNhiE
	 W9HSOk4MS0NMA==
From: Christian Brauner <brauner@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Amin Vakil <info@aminvakil.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, linux-kselftest@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260618151444.124739-1-info@aminvakil.com>
References: <20260618151444.124739-1-info@aminvakil.com>
Subject: Re: [PATCH] selftests: proc: include fcntl.h in proc-pidns
Message-Id: <20260623-visier-zulauf-morgen-50e686cc03fe@brauner>
Date: Tue, 23 Jun 2026 12:13:05 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-8bbda
X-Developer-Signature: v=1; a=openpgp-sha256; l=875; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XwTPIE05CmJRQWmA5uydOicG/inBuJ0Nzsm7ufk8+FE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRZxZjynJjj9v3Zka7UD/PnG9QuMZrb8qH73Kv/T/JiO
 8sXngi16yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI5AlGhgV8Rkv6BcrmK31V
 u7A8S+jUl8UZPfK3U1xFzW9z9kyeuZCRYcWjeQvk+h7t3zznE2foW86fv1UqXuQ5CG01YzeYbnv
 mFCcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Thu, 18 Jun 2026 18:44:44 +0330, Amin Vakil wrote:
> selftests: proc: include fcntl.h in proc-pidns

Applied to the vfs-7.3.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.misc

[1/1] selftests: proc: include fcntl.h in proc-pidns
      https://git.kernel.org/vfs/vfs/c/03ebedea000e

