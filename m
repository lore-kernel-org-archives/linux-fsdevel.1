Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AF12E413;
	Sat,  7 Feb 2026 05:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770441079; cv=none; b=YoU6uR6Uckn0SUyztPUzfil/nzgprnJqZtnj+jQK+uEIUYCo4XgfL81bxeMcfOBEuQqpUBGR1T4TT/BKIdMLteYsSnIUklzenAEHvukdJhGWJudKQLpgEiq6fvFyKsHLEG/570R/cEUA98jDzs6VDULywX/buzEPLRDIO5mxcKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770441079; c=relaxed/simple;
	bh=qTzKhZNXwHVLYTf48aXOvVa3sr2f0EvTD39+dYN7a8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuIlFWtNPoAmyDiQT7jkbBdJcea4O19G1SxQJyHJYTv9QO2Lo/WMNb8HZZBjz0i2NshnrbdRphZnjzQbs6Pt+JgrUMYQ2NmhTVYny8E3UTERDrwu4+CwyH1u+I6JVAmVWplOpcJ8Mo0mgq9tsez1MpIqdj4qnDErQQ7Ej9Y2q28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWlLD7DB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWlLD7DB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA57C116D0;
	Sat,  7 Feb 2026 05:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770441078;
	bh=qTzKhZNXwHVLYTf48aXOvVa3sr2f0EvTD39+dYN7a8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWlLD7DByQfq234L3rRVa0gAb2rFhLwpW7b7XNaq00bLoRDpeJclHY+E7XJLBFaGM
	 nVr8PmvxwVptEofZhwXvD8cOWhERNvBMvkd41UsDOfrzz0p26VJVlq6PJvtDqkRA7k
	 jp7itOIyUtK+0qM6hFprhIQjr6YYwLMlkqtHzlOHNPZPrJWdlWvceq4kY/iwrGDFc8
	 Eo5VIm9CRFjeazIJwOACgYmb5/+fdHefFYsMLgY3koQ94w7N7ksil7Ro07247YhKdR
	 Vs19zDaWR5VtLFzPXQoMtOFMX4qsjjkvHAfUHp7DOoLoleOmE4DiNr85yE/PMMAIO7
	 6qHQURjf4RRKg==
Date: Fri, 6 Feb 2026 23:11:14 -0600
From: Nathan Chancellor <nathan@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 12/12 for v7.0] vfs misc
Message-ID: <20260207051114.GA2289557@ax162>
References: <20260206-vfs-v70-7df0b750d594@brauner>
 <20260206-vfs-misc-v70-be6f713f9fa9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206-vfs-misc-v70-be6f713f9fa9@brauner>

On Fri, Feb 06, 2026 at 05:50:08PM +0100, Christian Brauner wrote:
> David Laight (1):
>       fs: use min() or umin() instead of min_t()

This needs a fix up for 32-bit builds:

  https://lore.kernel.org/20260113192243.73983-1-david.laight.linux@gmail.com/

  $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- mrproper allmodconfig fs/fuse/file.o
  In file included from <command-line>:
  In function 'fuse_wr_pages',
      inlined from 'fuse_perform_write' at fs/fuse/file.c:1347:27:
  include/linux/compiler_types.h:705:45: error: call to '__compiletime_assert_508' declared with attribute error: min(((pos + len - 1) >> 12) - (pos >> 12) + 1, max_pages) signedness error
    705 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        |                                             ^
  include/linux/compiler_types.h:686:25: note: in definition of macro '__compiletime_assert'
    686 |                         prefix ## suffix();                             \
        |                         ^~~~~~
  include/linux/compiler_types.h:705:9: note: in expansion of macro '_compiletime_assert'
    705 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
        |         ^~~~~~~~~~~~~~~~~~~
  include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
        |                                     ^~~~~~~~~~~~~~~~~~
  include/linux/minmax.h:93:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     93 |         BUILD_BUG_ON_MSG(!__types_ok(ux, uy),           \
        |         ^~~~~~~~~~~~~~~~
  include/linux/minmax.h:98:9: note: in expansion of macro '__careful_cmp_once'
     98 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
        |         ^~~~~~~~~~~~~~~~~~
  include/linux/minmax.h:105:25: note: in expansion of macro '__careful_cmp'
    105 | #define min(x, y)       __careful_cmp(min, x, y)
        |                         ^~~~~~~~~~~~~
  fs/fuse/file.c:1326:16: note: in expansion of macro 'min'
   1326 |         return min(((pos + len - 1) >> PAGE_SHIFT) - (pos >> PAGE_SHIFT) + 1,
        |                ^~~

David sent another patch before that one (though it does not look like
you were explicitly sent that one). Arnd also sent one.

  https://lore.kernel.org/20251216141647.13911-1-david.laight.linux@gmail.com/
  https://lore.kernel.org/20251223215442.720828-1-arnd@kernel.org/

Cheers,
Nathan
