Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583D434DB7B;
	Wed, 12 Aug 2026 07:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786519245; cv=none; b=NdgZ8lZxqXdqWW768qQynRJmYVnQt5JkbrrHtP4xSlPY8gQAuX56L/PspCUzoO4TeTuHHV86rxmFFeMNshx0QDC+Cvw95Af8bKK6BLQEIhcyaDKHWrEJcMdnbTtISJYxvQvTfaDKv6M9mc2zW4qYk0JPtNSicEhEJAYO3pB47jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786519245; c=relaxed/simple;
	bh=FBIhbS2wvMv4iplkO9rVe6W1nxR2eeXLLBUwM9KdvbI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VsLzEHxs8xvlM35nhxVMPXtIItTTGC0+PbwFXR0+pX6c6HvEmiqT/Pf9eMlrpIw/KXUpOees0QsuSus9NVZ1bPFAHGeYL2SCD4BoHkcQ5A/q530qB7CkAUHHA6MtGJfD3VCEJ0Edr0KuASDoblt+7/mGRPEzCRvaUooPbpJzjPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0RZK2hQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0RZK2hQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F7A1F000E9;
	Wed, 12 Aug 2026 07:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786519244;
	bh=XwOx99E5L6i1IGijIVQOV7C0HqDTRdGmibtsv8j9tec=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=G0RZK2hQU4/+i+QvJVxebJYcOPBYXjISZ+rdkGI9tfBVRaB9kq69uuJ2B1DYbdzJ1
	 pPvFzQ08iZ9JUY0//qIH7lGdRBTUaATAwG/3r5IhO3eYhPjUroNOwvMkVX5nRs69u1
	 ZVn/S5litSd7feaPQNvNufy7MUabqjuhJclvv7h7j/hYWmE3CXODgMsc0IzO7HRC5L
	 j4wQxMDfXQvgshmd5JEoTFrU3aEwSyddU3bcxRsUEU667ezQWwsGewATgYy1EhZuBd
	 kAU4PFx6jp6JxBueXe0v8WK0vlsboQ78CuKFYNkoIeMaqWVrLJ8rE+ZujkZ+WZoAiL
	 HhAj558VC81Dg==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20260808123802.73687-1-kmehltretter@gmail.com>
References: <20260808123802.73687-1-kmehltretter@gmail.com>
Subject: Re: [PATCH] super: fix dying superblock warning messages
Message-Id: <20260812-zuwenden-gekapert-urzeiten-80967e8dd320@brauner>
Date: Wed, 12 Aug 2026 09:20:38 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=880; i=brauner@kernel.org;
 h=from:subject:message-id; bh=FBIhbS2wvMv4iplkO9rVe6W1nxR2eeXLLBUwM9KdvbI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVyJ3aHfXPyKj5gujKmBsXW9tCI9RiAhirIqedcir/Y
 96Vwd3SUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJG9hYwMZ3+lB1RZJnAYrkpY
 w6jf4V82cbPX1CMcguts5db8zN20neGv+NqF15JWH6uT36BofNZLe46gBPvRn5v9Zf/E33Wu+G7
 CDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Sat, 08 Aug 2026 14:38:02 +0200, Karl Mehltretter wrote:
> super: fix dying superblock warning messages

Applied to the vfs-7.3.super branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.super branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.super

[1/1] super: fix dying superblock warning messages
      https://git.kernel.org/vfs/vfs/c/9ac8fd831252

