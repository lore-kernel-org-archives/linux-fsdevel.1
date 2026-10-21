Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577971;
	b=upRvx/2vIDn32b6sQYKAm0Hub7fWEM1ZKaNttMcOL8o2QAhMGBmt/uOvFFM1kWJhfEvg
	 +odu3OT9PJykpM1FXtBtbO6tq5CwYGSizFgXSs1QGPZGH5I8PpAFJEKx5n/dFZ5ieCy4Q
	 SoGHUt93JyaCgF9e/00UwDswJaZHKmhG6CMaMGqiKeNmn9BY5JIfRUBVMyBduMGBAFnGa
	 pp9ZxNeYNlF9NC/dN+6sHd0tpJiXnn9c7H8X/Nx7G5qa1EjcpM0Fsf9AMUxLclTU37KSI
	 CiPpP6IxNXnVtg3RuHseDY1oXEaT7SIk/xX7Rv/bK9sXnnSt2qXymZgt2Vmubqx5mgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577971;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ay77EXNqEX7darV7/sCPxjt1o5SOM6DHgvAXWVRp7ws=;
	b=ZRWv12tDXeuVDDK1us3WvMB2MJN/rOkdz8fhpv21vYFKtaxYAWZNZoGiWgWtqz8b+xKN
	 uuVzp9r4vM/3NVzxa/rHADfR3x35PKzI6ciqlipJ4tqtEBiL3UXN6160guS6gjqpsa1sM
	 C9kZ3UMfYLIRT5WWZ6/j5qgPjkaTeBbMYFYteQvp/WMuKEV0EtNijMVCfwO5QG+xM6jIb
	 LBkvEHFxOuAFMFr1RAU+cUVPXkQFhEOEuMO14U5kPsMdLgQhTO/5t8OdqPpzWjYUZybgu
	 89MqeZiz2kKwuGBtCZBKGW1HUXvRpeYKZeM1Bl+REGj76ernABVBLJoSc5yFz17G4Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rfmz3zVs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6396D606A31A
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rfmz3zVs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774FD1F000C9;
	Wed, 21 Oct 2026 10:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792577971;
	bh=ay77EXNqEX7darV7/sCPxjt1o5SOM6DHgvAXWVRp7ws=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Rfmz3zVsfTnHeRUuXrDDsIWpIWv5L6iazYomH1sErlTOR2SqlnrOu6dI6pL7jDHN7
	 joOw0ZIzQSXLdm/HB/eBdHxEuTKv4wpKFPEEBTpB0UQpYCPI9vTbwHCHr57iSuoftw
	 kdRzBlRz9j1GXPvBg0Lps75kUYcsw9xwz0rUVU9wy4/3jKWD5V8d1YMs+1Kiu5EDw+
	 O5iFZJwsMHNGgM72iDaqQGUtUIzxX6PAzyH4CRN1imsl2Rgk717gEUnTzN6QIBVjfY
	 Nzez3Cf/Drtb1QL1MUDV8rxy7HJrJKmlCUM1Xqgot9EA4EIxjdOgzDDOufW+/BMso1
	 mwuEWbKDNWEgg==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, Julian Sun <sunjunchao@bytedance.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, tj@kernel.org, 
 akpm@linux-foundation.org, roman.gushchin@linux.dev, dennis@kernel.org
In-Reply-To: <20261016115230.3640770-1-sunjunchao@bytedance.com>
References: <20261016115230.3640770-1-sunjunchao@bytedance.com>
Subject: Re: [PATCH 0/2] writeback: fix timestamp and dirty-state handling
 in wb switches
Message-Id: <20261021-geurteilt-rekord-bestbezahlt-3c84d037333d@brauner>
Date: Wed, 21 Oct 2026 12:19:25 +0200
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
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1115; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RepdeC0du6R3CU1UYi3OtXy4LyJRRiD9aVnxAOiU66M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdmLhezKH8JZvAopub7t0yvH/80KH5qiYtfyKeGZbZs
 iueWvy5qaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi91MZGb6aG088ctUltPWk
 MIdm1qkI07dM3iudORv9XfSP26QnBjMyXJz3rvbh7yknrZdbbjv/X3H/HMOn1tuOxjer3mstey2
 wjBsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Fri, 16 Oct 2026 19:52:28 +0800, Julian Sun wrote:
> writeback: fix timestamp and dirty-state handling in wb switches
> 
> Hi,
> 
> This series fixes two issues when moving inodes between writeback
> structures:
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/2] writeback: reset dirtied_when when switching wbs
      https://git.kernel.org/vfs/vfs/c/13b9a606dd0a
[2/2] writeback: clear old wb dirty state after inode switches
      https://git.kernel.org/vfs/vfs/c/a396fe9f74ea

