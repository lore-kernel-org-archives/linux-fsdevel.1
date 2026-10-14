Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CD84E1C6C;
	Wed, 14 Oct 2026 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979773; cv=none; b=dN8+H33ZeBJSZG5fCTfjP5dhIDRmccpMTF4VBHUAU6iheeEy2pV8p2QcUt5u1Lk/8r4Ww9hZxWJAVmGeVBxGIc46mQhdItKrGbbofm3JeEVe9/UovtaLJSPJknfT061RYwMwSd+1kQNyGleZJUtmUPPXejQxW13o3UxAPpz2sJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979773; c=relaxed/simple;
	bh=IZWYrIzIzS0NvQVwjS+EjuJaGyE9lCGeFWEfoszBmDY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P0yWT/8gcnV6JayF4miEL9AgxR3eL3ugBv62lFRYYywQFqhnRKb06x4xOuzkoJfwz1bcLn6XR1pB9F/fJK4Ume4i+YV8B+Aiij8aAkATisjDjnDFqHDZihgLEQPcAeqFS21NJ3s6t3kYMndVQcup57PO8ad5Yt2hZhwYU6KsigQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+6i16WM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+6i16WM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60231F0089A;
	Wed, 14 Oct 2026 12:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791979766;
	bh=mFWfOSS5lvfx7vga/WWDPCNnBR6cUwPgQydOg6nfUYo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=F+6i16WMxMQCyRdokR3qBU4HvjcaOkRaKFOjUIH3ujeHQX0mUD5kJMJ1lLoZ678/D
	 M+btFvZybaX0jzHKOdNUa+NuFXtA6rs8GpRPDl17NpL6WGGRam9LytRn2gak46ETTZ
	 GwauBt/KV2KSeDEIF7Sut+VAJRrcKHiUqzADXWvxvqt3KhK1ClZdlP12qmnwCnIqGJ
	 FZcFYTp5hRterYgyQEEIF5qmJBvN3TT/FFOvvuYf6Dy0DwJg6OSExf1RtAu8MepcfL
	 zDn8XVoPeX7TGc4LZHKrNN7YjRt6yxdAEpRKWT22bKcikZRBTG9Z+EJ3MGxF6UnJ2o
	 PCZRDo2DJ943Q==
Message-ID: <9dca283d-1051-44c1-ad0f-dbf5d4519a51@kernel.org>
Date: Wed, 14 Oct 2026 20:09:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: opt in to multigrain timestamps
To: Jeff Layton <jlayton@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261012-mgtime-f2fs-v1-1-a934ef646c44@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20261012-mgtime-f2fs-v1-1-a934ef646c44@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/26 23:46, Jeff Layton wrote:
> Set FS_MGTIME on f2fs_fs_type.
> 
> f2fs meets the multigrain requirements:
> - ctime updates use inode_set_ctime_current()
> - f2fs_getattr() calls generic_fillattr()
> - f2fs_setattr() calls setattr_copy()
> - s_time_gran is 1ns
> 
> Exception: with CONFIG_F2FS_FS_POSIX_ACL, f2fs_setattr() uses a local
> __setattr_copy() that sets timestamps directly, bypassing
> setattr_copy_mgtime(). Make it call setattr_copy() with ATTR_MODE
> cleared, then do the f2fs mode/ACL handling as before. ACL builds now
> also honor ATTR_CTIME_SET via inode_set_ctime_deleg(), as non-ACL
> builds already do.
> 
> Assisted-by: LLM
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
