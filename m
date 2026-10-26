Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793046922;
	b=fhZ5TfVOnVy21SCE5gt/hjBMBFIYzUKwEblKaB3ZUNgcMyxT1HnlZF4nXcv5k9Qwd5IM
	 CFLjBUYilRxJA27EFVHm1x9UQ7WI8p2vucyS2ahDgeeLzCGP/G2Q0qqCrK7CQ4oEayB85
	 IIY69L5h13MMbOw+ss7wkjtz1L2+YLO/y1rJtpSI0dp/1PjRcFqLwFd/bvMOx94XHuLrk
	 Bv8eQB4LCdF2fdw+9qbMqzYSz6gSSIet1CpOyZMp0w4EWeAZhmX6iSpj2vNtTPYKsjtxx
	 2RziIojusrZk+ekUZK6s3/b2ttl3pFJWxxpd4tPy35ViU/nAyvM7aqvxGqRDj3Tn3BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046922;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=SfxvCvNIgMd82NMe/dMUUlbFHffdL/sfl2g3on4+8kM=;
	b=Q8x9G7o0vAf0MfQqw8GyHZmWtbV/4IINAt+w3f2nxuDnjZ5wIn3AfBzvO4kDBMkDlQsi
	 llhg9FpXj0MFkXi0NDlqQLg4WETILXu35tm18kJysv6YGMRCIEe0DgAO/zvf1XP1DmAOY
	 8d0uhTa5p5JEC4ogG6E6A3rnVxG89+MnXbfVTQvM0MM0w21yuSyWCD0S9hAhBtEgHwjxJ
	 rclhEQPbfsCZ6FG/X0p8D24WXM0HgEl78VvU4oeXxoeHdLa8J7lW6iAeEd/0rmORF8f3w
	 3AQibC/kninKkwrumkAERvA+ZxAFMfIfZniGB9h4XFbmfuLTVpyuZ6fuWZiRTvt5gxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SEFmFLEY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88904606A31D;
	Mon, 26 Oct 2026 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SEFmFLEY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6181F01825;
	Mon, 26 Oct 2026 20:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793046922;
	bh=SfxvCvNIgMd82NMe/dMUUlbFHffdL/sfl2g3on4+8kM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SEFmFLEYOYC59BcW3gsooaCFsNGdzwsis6g69hePysXLEhlGCDOFyObKBEcAAl2rP
	 eobK9DCR29DX6gpBhKTNLmKXhGi3KRAoI1L68JXEkJsG3kX9TbAYRPvNMBwULBbx+y
	 CYd/p5gM4DBzXlX1UkQS7Kf2sRthlJnJWjgd2cRp6rgP8yaGwlHenDxBEfNLoDzd6c
	 ERcPlBE2kxtGLDI+ab+j6Vc3ManoG8gYRC8+0XIIIVRu1eOjp/SANH7UhnoZ0/DGnH
	 tgrXSKhydzDpdyLp9bZsue3GMFhau9uOUeaoa4wehVkmpXAoGB6VUQ1MVZ4i/PJA7L
	 yLvT3BukCyt/Q==
Date: Mon, 26 Oct 2026 21:35:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL for v7.4] vfs keyring
Message-ID: <20261026-semester-gabel-hallimasch-34a1d883b295@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
 <20261024-vfs-7.4-rc1.keyring-db88a8f3b5b1@brauner>
 <61898b2b9de5e6be98c7b8e462ba29595cae3e26.camel@HansenPartnership.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61898b2b9de5e6be98c7b8e462ba29595cae3e26.camel@HansenPartnership.com>

On Mon, Oct 26, 2026 at 10:10:54AM -0400, James Bottomley wrote:
> On Sat, 2026-10-24 at 12:44 +0200, Christian Brauner wrote:
> > Hey Linus,
> > 
> > This is a delayed pull request which was waiting for the bpf merge.
> > This used a shared branch.
> > 
> > /* Summary */
> > This adds well-known key ids for the .dm-verity and .fs-verity
> > keyrings.
> > 
> > Neither keyring is linked into any other keyring so request_key() and
> > KEYCTL_SEARCH can't find them. Userspace has to scrape the serial out
> > of /proc/keys before it can add a key to either of them. That's not
> > great as any user can add a key with a newline in its description and
> > make /proc/keys show a fake .dm-verity keyring line with whatever
> > serial they like.
> > 
> > /* Testing */
> > 
> > No build failures or warnings were observed.
> > 
> > /* Conflicts */
> > 
> > Merge conflicts with mainline
> > =============================
> > 
> > No known conflicts.
> > 
> > Merge conflicts with other trees
> > ================================
> > 
> > No known conflicts.
> > 
> > The following changes since commit
> > 1b7415bf70be95b9a1e7e87d544867881065613f:
> > 
> >   Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf 7.3-rc2
> > (2026-09-06 16:17:40 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-
> > 7.4-rc1.keyring
> > 
> > for you to fetch changes up to
> > 503b65da9a7e5447d91222f62399522f2f62a0fa:
> > 
> >   Merge patch series "keys: Add well known IDs for fs-verity/dm-
> > verity keys" (2026-10-12 23:37:42 +0200)
> > 
> > ----------------------------------------------------------------
> > vfs-7.4-rc1.keyring
> > 
> > Please consider pulling these changes from the signed vfs-7.4-
> > rc1.keyring tag.
> > 
> > Thanks!
> > Christian
> > 
> > ----------------------------------------------------------------
> > Andrew Halaney (3):
> >       keys: add KEY_SPEC_DM_VERITY_KEYRING
> >       keys: add KEY_SPEC_FS_VERITY_KEYRING
> >       Documentation: keys: document IDs added since
> > KEY_SPEC_REQKEY_AUTH_KEY
> 
> It would actually have been nice to copy the keyrings list and
> maintainers on this.  I don't think there's an objection but not cc'ing
> the list and maintainers makes it look like some type of end run.

Uhm, they were?...

    From: Andrew Halaney <andrew@amutable.com>
    To: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,  Alasdair Kergon <agk@redhat.com>, Mike
            Snitzer <snitzer@kernel.org>,  Mikulas Patocka <mpatocka@redhat.com>, Benjamin Marzinski <bmarzins@redhat.com>,  David Howells <dhowells@redhat.com>,
            Jarkko Sakkinen <jarkko@kernel.org>,  Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,  "Serge E. Hallyn" <serge@hallyn.com>, Eric
            Biggers <ebiggers@kernel.org>,  "Theodore Y. Ts'o" <tytso@mit.edu>, Jonathan Corbet <corbet@lwn.net>,  Shuah Khan <skhan@linuxfoundation.org>, Randy
            Dunlap <rdunlap@infradead.org>
    Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,  keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
                                                                 ^^^^^^^^^^^^^^^^^^^^^^^^
            fsverity@lists.linux.dev, linux-doc@vger.kernel.org, Andrew Halaney <andrew@amutable.com>,  "Christian Brauner (Amutable)" <brauner@kernel.org>
    Subject: [PATCH bpf-next v2 0/3] keys: Add well known IDs for fs-verity/dm-verity keys
    Message-Id: <20261008-ajhalaney-dmverity-key-identifier-v2-0-008456d189cb@amutable.com>

> > Christian Brauner (2):
> >       Merge bpf keyring work from of
> > git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
> >       Merge patch series "keys: Add well known IDs for fs-verity/dm-
> > verity keys"
> 
> This is a bit nasty because the keyring specs get renumbered inside the
> merges ... it would have been much clearer to people looking at the
> history if the patches were rebased instead.

Nothing got renumbered. Both merges are clean.
The only commits that touch the ids are Daniel's bpf one adding -9 in
bpf-next and Andrew's two adding -10 and -11. The branch is the three
patches on top of the bits shared with bpf-next with an explanation why
this was needed.

A rebase would given the same commit but would've meant invalidating
things that were already in -next.
