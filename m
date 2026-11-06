Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957325;
	b=3fVUAiURTS44TjoGQ1pv7Aah/a8VEbAoBZOvCycNWlZ7OS8BJnUrrie5ZBrScP0hMF0p
	 21zxSlKDIN8nbmfH1cwHmKY9uhWV3hDvnQbYRtwEk/WeQ9bxn7w+Qg4LdUvUB9HQ1hMHT
	 kR3xtJJDPXCM2Xe0OYOWPR0HCm19hnKOht/swRQRtld0VOqdOJNFZS3u6Gvnbn8z/7YTX
	 Z2+2dQK2BRqdEOAYdQeGZbFClZq+zLnqnPGEJvAw8Jpl00vWjnV5roS0ZBYIa0r5Vduwr
	 LGGGEYsINPWjWnjQHYAAlFLdxMd9YRUkQ2LPIwi3dOT/bsb/9JG1joYP7HdZTCLO38g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957325;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=VC16RfQ/Ch74ykYoajUZJ+R1KFdW7fHzBmB94MytVlk=;
	b=WzQxChkHI14oFq4yEbBaoozusuAfMETEJqHgsvIlbbrk3f7FJMyKM0h0ede1zTF2wlNW
	 tPdrK3zRAHQnUUaHigveEg5wBUFkPF8iMzTIFCABBZfq0zm3T3FZj+jIkGjxYZUtFZaCX
	 W7v5YMGtmIOevBz4VVk1l18Xfj3sKMz+K/AnlFyMQFaTf7V1KRgfvFL+bNwPJxxra0WvX
	 3rDyoKisrYk0d63aKxIdNezjdauRpVXfh3viFfcJUHrNXINP7TwO8D52bIJzEbZVsHZOC
	 LQkd3+5+VkpH+w5+o7L0fPzhMuQqVMR4z4+VgzaN1tWoqXO/l910xeghKnN2lvUgqkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqeWePhs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1504606A326;
	Fri,  6 Nov 2026 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqeWePhs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C551F0089F;
	Fri,  6 Nov 2026 09:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793957324;
	bh=VC16RfQ/Ch74ykYoajUZJ+R1KFdW7fHzBmB94MytVlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kqeWePhskc8HNNCmYcdAWgvx59rFaItJGQOF/OyXIt/sCZd7S07yg+8aS/fnB0zNp
	 VZWmUIjL5yONrrC/I3jiwH2+dnKikXHjGeTuLUGr0j0eRPY5SO/KWrCGOFcgNA3ZZL
	 HdLccbtIl2+rB52+gfXthzuEXvhI4yjsjlV4x4GCkb7bizD6hCKSxpyMWCje9+/s6U
	 4d4hYcIqy+tap693g+yX6oZ4XvZL7fnGPKzTviF5CpGIRYQ1kG01IAXQpkl7+VYCF1
	 E9JusScvtWLyNrSjSK8j0HDA6lphKi+qTFh2GDRYyMedmYzEVbuuhiiS7jnOcasf3z
	 PDOC78hNF61Zw==
From: Christian Brauner <brauner@kernel.org>
To: me@bobcopeland.com,
	Hungyu Lin <dennylin0707@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	willy@infradead.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	geert@linux-m68k.org,
	tsbogend@alpha.franken.de,
	maddy@linux.ibm.com,
	linux-karma-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] omfs: remove the filesystem
Date: Fri,  6 Nov 2026 10:28:33 +0100
Message-ID: <20261106-vortrag-exotisch-pelzmantel-66235662f81f@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105044046.52180-1-dennylin0707@gmail.com>
References: <20261105044046.52180-1-dennylin0707@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286; i=brauner@kernel.org; h=from:subject:message-id; bh=i3zpqEJ74dna9za+0x2JJjtzgM6lB6eRNkY0jcS+yfg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9nXv4bfPNlUcWTPn4uXNLgONU2auKFum3j/m/yNjO3 u7/4QGPcEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEkjYzMkw6HKYfmszBsTjg nQ9D0/sLfp1fF166+WGPjq32xIUV3GcZfrMKhXHuzlJ3P5KXsnvXZd3mx77RJ1add2gs+WygyOB fzwsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 05 Nov 2026 04:40:45 +0000, Hungyu Lin wrote:
> OMFS supports the on-disk format used by the long-discontinued Rio Karma
> music player and ReplayTV DVR. While reviewing a fix for incorrect block
> mapping on writes starting beyond EOF, Matthew suggested removing the
> filesystem instead of continuing to maintain it.
> 
> Existing OMFS media can still be accessed using an older kernel with OMFS
> support.
> 
> [...]

I agree. It's great to see that we are are able to shed a whole bunch of
legacy tech.

---

Applied to the vfs-7.5.omfs branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.omfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.omfs

[1/1] omfs: remove the filesystem
      https://git.kernel.org/vfs/vfs/c/b4d257187fe7
