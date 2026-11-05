Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896588;
	b=JlVqQ68jOS0Y/oHZcVRfIHj3V6W8qEfzQsSmnPharU9mwglSsuN/i/D1U5lAAQj5GSih
	 8+XFw47ccieBOjwIEyRLLFHzU9Zplz7F+gxPBvXi+OVgYK+W6tgF7ynzFW8zFyM+qn8el
	 6HYtPI3/i7OX9Ch8lbUT+0fNO3/4e0y4vdnXL8mYRr+VPZQKXnzxZc4lR4oQ33uc7Z6cZ
	 SMJPeNJjcwzqwhRvgqwUZ7eltzYo3u0uzB0lUPnhzrlLSQrw2RKZjUfHfqABLyhssxbPd
	 tF5Pp9zhcu/G2n3zaMQVN4Uu3LVFxbVM7JE5faZQbDGhJR24/tBbbioUJw0bAu7zAEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896588;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=pVmMCx2OeqLOUQsCqoIfkHlqoCpOdY0Z9Uuav6Jr5vA=;
	b=w4/Ca60W05SR8YQNuSvOO1gmZrsNssiOTnKf23NFkJdlLNJxGqLHeTKnyhZ4JzCGH6qH
	 hZpsdGqzeCb1A6uYHTaCKYnmS4dimEwXExMiufJGKy8HJPH5zaZBbIqAY2TUUmN1OKjFE
	 5mcvMi0f9zTMo7oTOOf/Q6dFUY7BXQ+xgaKBDpiw1ySDOtVD59xUllEWH+QrPXTvnK7Q6
	 mgxop+ccda0tlnaNYazT+/4sh0/3kw3S6n65xYsWhzix9TSd4mXJ7hhhXgswdAGVLslEP
	 7mu6nr96lAF+9CBtqyoEF3rbelz10g+VwFFEuYglSml8blf/fBqo+OugO+AsHH1dVWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HooGQpPX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6C7606B3DA;
	Thu,  5 Nov 2026 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HooGQpPX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346BD1F000C1;
	Thu,  5 Nov 2026 16:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896587;
	bh=pVmMCx2OeqLOUQsCqoIfkHlqoCpOdY0Z9Uuav6Jr5vA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=HooGQpPXoyzfiCMLwGkTljYCtX8tTXLHOkwDt/GbgIopSmp92aY1exQn5Q6mucByl
	 3eomkcPPwYnm3rePdTtXmoA1J8xS8u0goEwtDnl3sWs5UKWGWTQqWwW3iz+J0KFzCk
	 IHkvF656ekv4R/psYYqdUbdj+bjkHQt9nuQu+Ow/51RS5RcEkZo508ix9TVvIMcWDd
	 j+n3naMUPej9USBj3CjCy8gJp72ZE1abh1iUrx+LQ67ZhLJhlajuNHHlosLKEXWn1C
	 KUz7luynabriI7bdOViUj0vvygUJRfG9WeRlqcawGsyQxZUosEPWOSXHzo8Baz2Utq
	 VufN9ww+FiD0Q==
From: Christian Brauner <brauner@kernel.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Deepa Dinamani <deepa.kernel@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261101113815.52911-1-dennylin0707@gmail.com>
References: <20261101113815.52911-1-dennylin0707@gmail.com>
Subject: Re: [PATCH] vfs: preserve subsecond timestamps at filesystem time
 limits
Message-Id: <20261105-umleiten-hergab-magie-df41f0a73216@brauner>
Date: Thu, 05 Nov 2026 17:36:24 +0100
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
X-Mailer: b4 0.17-dev-ce4c1

On Sun, 01 Nov 2026 11:38:15 +0000, Hungyu Lin wrote:
> timestamp_truncate() clears tv_nsec whenever the clamped seconds equal
> either filesystem time limit. This also drops the fractional part of
> timestamps whose seconds were already within the supported range.
> 
> For example, setting a JFS mtime to 0.123456789 produces 0.000000000,
> although the filesystem can store the requested value. Utilities such
> as touch and cp -p consequently lose valid subsecond timestamps when
> preserving these endpoint values. Timestamps strictly between the
> filesystem limits are unaffected.
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

[1/1] vfs: preserve subsecond timestamps at filesystem time limits
      https://git.kernel.org/vfs/vfs/c/4b18ced0bcd5

