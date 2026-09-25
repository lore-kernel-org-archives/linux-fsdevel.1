Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E21C4B7160;
	Fri, 25 Sep 2026 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790348102; cv=none; b=J357cqH35LfGSBXPZsu/x6E6wEJLUaiD5dmIMUCSNRSGGyrg231GGRcm8MQG+SHkwTvZVp70qMJAQb8imwlLgfm2q+Qes6czt94oFWTM23DoHD+U5vZX8G9fZnSvYIi+zVbl2FFsMvQlszQzS6nEdFxzJlvVMeS53tDOiAUh2rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790348102; c=relaxed/simple;
	bh=DSElJr8+eqnncUV1+QmO3mNU5DAG4Xkcag5Qg0INYEg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bHGp5Sleg3Bii90/AP3ccMTePjjhBVFKeKgBJv/fa4nL20XBOaa8Vmk4ST47/1AUTw0PfY4eF5WS3sv7uH16Nz//C/1tAE+Qkw3eyrAmMPYtffW2De4Om7TjCvTX6I74MavB9lbid6mFZhPC8cbcGHHSLn6DgeVfYNpSzHCg6e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOESLnPm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOESLnPm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB201F000FF;
	Fri, 25 Sep 2026 14:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790348095;
	bh=JGrB5YYFveIwZSzWD+7LH6wodZl8bTW0nco8xHfgyM4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QOESLnPmLuTQ7cdOc57AH46fsAY50EQ77MsLUxkgKnJyWYsA1CTQb9Ka6hBzSobn5
	 +RaDOGcelCVIE/1lAOY5o5ufvWy34WDudrgeJ2vYlYXA2lQZy6bIlmo3QZc95wSLXH
	 fX8sXQE7TKC2/uIfUVZVfjBUrEBjQ0Lz22Umc3gOxon2zWvqo32cXEQMHmboDdCMZV
	 tuCoJGEmSXIB4VjGIqKZE2Gq2V48nGM5/ClqoTQXR/T7J8AYeWYi0tZaL4i/K9k4jE
	 EEUwYF5Oq97Gux/BxaxFfDyeStYLsvSLwMSOuY7YfTQ+qHAskaWjd9UkWGi9b8sHMS
	 qF74AV0fTDj3Q==
From: Christian Brauner <brauner@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>, 
 Breno Leitao <leitao@debian.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, kernel-team@meta.com
In-Reply-To: <20260921-kdump_print-v1-1-e445fec3177c@debian.org>
References: <20260921-kdump_print-v1-1-e445fec3177c@debian.org>
Subject: Re: [PATCH] vmcore: report the release of the crashed kernel
Message-Id: <20260925-wachen-handhaben-mixen-431c4a7a196d@brauner>
Date: Fri, 25 Sep 2026 16:54:49 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=881; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DSElJr8+eqnncUV1+QmO3mNU5DAG4Xkcag5Qg0INYEg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRt67YSFX6fWhzrmPw15FtycOBPpVX/NJ+fmmj1Lfv8h
 c21tf0/O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyW4Hhn0XeoosOFlcvc8wK
 uDpt765TJxlSDqzZ4R4+932ETy/n8bOMDHui05dZOTSU9mq6OkxNma7G4y6hKPVh4/zbXmlHahS
 OMQIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Mon, 21 Sep 2026 03:45:42 -0700, Breno Leitao wrote:
> vmcore: report the release of the crashed kernel

Applied to the vfs-7.4.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.misc

[1/1] vmcore: report the release of the crashed kernel
      https://git.kernel.org/vfs/vfs/c/9a82c64e133f

