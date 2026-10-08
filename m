Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5D9494826
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2026 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791465227; cv=none; b=DPqXoQmE4zNGk6svpVnksc9gkKbLchOmSz43UMHH2yKfcvCxFByR2k/tDu+7Q8fFNjJQT9L2NEMVh7oY3lfUVs93+LrHDtjZaZJlycURL8JGmHhVHrxFgDflVgrrrfhYBr3LuUhPFzevNE2OegcTu75J3OubWaaw+B0/wK0IjmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791465227; c=relaxed/simple;
	bh=7qtI5gtgg8HMBmacX6qKEDXcXJKwtRBJ+yKlbMqIu+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZ/CgiXcl7tsV5DkbZbWzmrtB5bsdX+xOzCDyjIGPh1y+bQZhmXuONWibB2u/1y4cch19pqsW7Q/UEnENxmmBrbHpR01iMuYtOk4lz9OAK5tjrS5hxNl5RlwkFUfI+d5evAMfK2/QFjkUgnbe9vanHJZzcYL3mW78Vaj7/+TyFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=D1SCMzeS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="D1SCMzeS"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a16bc2278aso22090965e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Oct 2026 06:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1791465223; x=1792070023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HO3C9RpYvCSZ09L6Ew5V40K2HpvgcXSKkDoFhjI9Kx4=;
        b=D1SCMzeSC+3lNkcoGtnd5MZUOxDZCN3wuNj/aDJI/4LcSRRqrhAqs/Hi9CUNMcqHFF
         scv7iSSgs0pq4DXVtxK1HcP+TX2UMEUKqgjygaUCO4jjwffdRYQ35mFnULVYKtlpTSr2
         NHsGPcZZ4Ck5RTw+UneynMefAFGqW4jY2LdZvX3S5iBQvtZZpf3hZOieucAkZf24jP9V
         NxADxxZhMnMZ1FL/SL8HTUDY6ROMGb323/c7WVSmvIz551S/ndHuV25o7mDAi9hg1ccq
         PKvBQP/BYKJM244I8ccBCcDKG4NhIg676rJptZyeAXQKxlYl94D2DZjm9gOjO6SQD5pl
         U8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791465223; x=1792070023;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HO3C9RpYvCSZ09L6Ew5V40K2HpvgcXSKkDoFhjI9Kx4=;
        b=twmkInNX6+93nPYULsyXfEKEg+E9S7kbSYPbj+QkqsMhOHR5y6DMH9xlRvr3NGpZ/r
         p+7kb/G7imI/Q3CFP/3Xn4/UzBkxsGfUdUEfetNI3UVy3PhzdAHi0LIvWtS5/9uM2T6z
         Hox7KDxdxsps3gDU8Jo210lUkFpT07dbufLURPvmcGa9ph0y4P0onDK1y3vfX0MyubdQ
         O44sRfg38k8HPyEURlCSGZDUCb2UdXneN9fmwime2z+pbVuqMZ0hOvd2hhfqJa0hAa5Z
         3Uecu0L3zls5+4Wk49vDKwJIoqa1YLg6q4ErPZY2R3za8dF+fCO3gCuxeRKLLkkucVaD
         imnQ==
X-Forwarded-Encrypted: i=1; AKwUvBw8te9DlOc+B31C9TDvGuyikDf74DNFucendC4RyWqkjp/VNQUBnzNsxoGNCUjeRUQXn4hBN0K3gfnazFc3@vger.kernel.org
X-Gm-Message-State: AFuF++lRd1hZMWQeHaiVIbpf5q0wfaqrrqL4fP8hzlFugCsfaRa3xT/I
	xWDOAxOulfAMAvNjZ5N5SlqZG3fxe7YPPjKIy/76AAL+/GCQ40AYNAP5mp2Hw7SM8Cc=
X-Gm-Gg: AYBFou34LVjHrwoHFdlhuxe9GVpGYpL81Jn/vMpZwECsUr+VNGPp33MSN/BFF6b1uVP
	UrUnJB9R0l2W5ACT8JrWVpEEeSkCONm8gh1UxUso4ES9qZ0k0qIDVwdVPOvqq5tfCvxpHqJsdxe
	lxfD7P0VA9IeEibMluoutIuXM8Xbu8lZRNuaxHWi3+1RprXTN5E/wAaN0kvP0P5091Sq2sxBmk9
	MvPWpfVF0eJiVNhKU/6bbHVTE7cT1X+nE2+ikdg1/fGungTDqRhOxGbKPzQ5D8jB9aWT98lokYE
	xEl54cefHJF7Ow9bxzrGwCXNXLuvxNUZnJd2hoEG1aiiLL6eKyX9IlMpuLhbfQBfXz2u5bzq4b0
	5PsTR993hJHDHbAfUHEiBGBKRc+osa1pd1/Qxybg9JQeQaTXk38BJVXiDAY7fo4n1OYUQpqdRZv
	PVcReT3+VbO9m4CfUmq90YxHs5BqloBBKSJmOt1JAPikuQJ+x1Ok4+m6WNRIPoHl2pk5Pc4oRy4
	nyvAho0dA==
X-Received: by 2002:a05:600c:19c7:b0:4a1:70f0:ac2 with SMTP id 5b1f17b1804b1-4a180648d69mr101498205e9.24.1791465222920;
        Thu, 08 Oct 2026 06:13:42 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([185.194.184.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f493761sm221404825e9.2.2026.10.08.06.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 06:13:41 -0700 (PDT)
Date: Thu, 8 Oct 2026 09:13:38 -0400
From: Gregory Price <gourry@gourry.net>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org, workflows@vger.kernel.org, 
	tools@kernel.org, x86@kernel.org, Thomas Gleixner <tglx@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Dmitry Vyukov <dvyukov@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Cyril Hrubis <chrubis@suse.cz>, Kees Cook <kees@kernel.org>, 
	Jake Edge <jake@lwn.net>, David Laight <david.laight.linux@gmail.com>, 
	Gabriele Paoloni <gpaoloni@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v5 05/11] kernel/api: add API specification for sys_open
Message-ID: <aseWPV6ZRQM3JOMN@gourry-fedora-PF4VCD3F>
References: <20261008084956.2911790-1-sashal@kernel.org>
 <20261008084956.2911790-6-sashal@kernel.org>
 <aseRXi7hMWBBc0tB@hallyn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aseRXi7hMWBBc0tB@hallyn.com>

On Thu, Oct 08, 2026 at 07:49:34AM -0500, Serge E. Hallyn wrote:
> On Thu, Oct 08, 2026 at 04:49:45AM -0400, Sasha Levin wrote:
> > Add KAPI-annotated kerneldoc for the sys_open system call in fs/open.c.
> > 
> > The specification documents parameter constraints (pathname, flags
> > bitmask, permission mode), 24 error conditions, locking requirements,
> > side effects, required capabilities, and usage examples.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> I know Kees and Jonathan and others asked for exactly this.  But one
> downside to this is it makes just paging through fs/open.c a lot more
> painful.  Maybe it's worth it.  Maybe "noone will ever do that again" bc
> that's why we have ai and tools.  But a) that's how I've historically
> done a lot of code research, b) IMO something like a manpages section 2
> under Documentation/ would be a great place for this, and c) we can also
> use tools to always sync these, or even show/edit in a single view when
> you want  ('kdocedit fs/open.c').
>

In many, many other projects i've worked on, these docs are placed in
the header as opposed to the .c file, but I understand there is some
pain that comes with ifdef.

Keeping it in the header ties the definition to exactly the location
external users import to find the function - so it makes sense.

But separating the contracts from the code guarantees they'll go stale,
so I don't think shoving it in Documentation/ does anyone any good.

~Gregory
