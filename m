Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D905F41A51A;
	Wed, 22 Jul 2026 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735877; cv=none; b=osJq3iQMvrRWrZoQoXUoZYNfORZODEnTCycok99kHg7HhoX3llHsbK9yfkTAkK2YPO0Qv69UPLTlwvKJxXBJ1fSb8KAfSBGUFCpyDckxNSFe1wNjgzsoFl16oXshFp+D5je441mP+P/BmBSssc8zrRhd8lqyuZoJvGT9z45dCpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735877; c=relaxed/simple;
	bh=awy5Sot30Co3frR6mhsLylGL+pvNuXhxm7CnPzaXy8g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eW74qRL1AeZ3fe3hy+B0XAlMzrV8pnadiNWFsQE2r8AFA7ouVTZrmTUjCa0TYY1nxY7TJmhFo1qvCx0hq3g6UiyxoW3gFEj7PX0tLTufy4/5X9QDTIFDQllXctP+X3Pvx0cSZAxVV/VRwqIASr5dUTb/reMGsjGloi8FefJ2PzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jaxjfffc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jaxjfffc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0441F00A3A;
	Wed, 22 Jul 2026 15:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784735874;
	bh=LMEYgQbWYP0bd8vBsuLEp0gUR7gdO/KtfG5+fdfHx3Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=JaxjfffcObiF+2LLhhaVpeAi6VFnYEWmunHJ3IUCmDS877BRjsZLysPnvbehudNbZ
	 piwQCEFPbZt0SF6XYjTmHqjR0Cz+guu/fY0HRYFios9AUF8qbtJWHxGIMvi+KEOnz4
	 uu2TyjtFQ5d8b751FF2IX6armAtlyiSpBmQ4937PImAk9dJt2HNwWZrms+R/Id7olR
	 TvvEkrG/5wnUCLxeVlmbtUe0uwYnUraDM7fHn4pCq85XHApH/qO3qE5LL4hjTfNUlv
	 2baHiUZo9gbGLx/6bb1W1J810RWh74aWg10JUlpNPvEZHshj4CpSjhI/jnk8famYuN
	 z1tqbuPfQO0mw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260720112331.1096530-1-hamzamahfooz@linux.microsoft.com>
References: <20260720112331.1096530-1-hamzamahfooz@linux.microsoft.com>
Subject: Re: [PATCH] mount: remove redundant panic() in mnt_init()
Message-Id: <20260722-kursschwankungen-trimmen-genehm-b2f3a5d3b1e4@brauner>
Date: Wed, 22 Jul 2026 17:57:48 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-2f6f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=879; i=brauner@kernel.org;
 h=from:subject:message-id; bh=awy5Sot30Co3frR6mhsLylGL+pvNuXhxm7CnPzaXy8g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQlvGjIan9mee2ilsQOCU3/KZJ/SienGwpH+pwPmKvUo
 Jj0mSWyo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLMfYwMF1ON70vrC4VLSPam
 ns9bti9YQcb9tMbl66JH2R2ZBOcuYmRYY6by9NlU4SmPFW9Zph2p4+Gseyz20bj4ihNjcoCl2WV
 +AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Mon, 20 Jul 2026 07:23:31 -0400, Hamza Mahfooz wrote:
> mount: remove redundant panic() in mnt_init()

Applied to the vfs-7.3.mount branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.mount branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.mount

[1/1] mount: remove redundant panic() in mnt_init()
      https://git.kernel.org/vfs/vfs/c/083e8742e301

