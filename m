Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793038726;
	b=ApMVJt0gV4BMnjNiTs2I3Y428VYCggXLDooD2AQOUzxMKumk3CQvNOrOlpeuVLPJbQ0B
	 c4UScV423O6j2WGgdS+EHskHRIGF7IFxw+4b9sIEsyVy3xTXSyKb1iHLjGaj9yazu+cze
	 rnuh6IFL+rZXbbZjFJcl48/p3PAQPqSkVtCSoHJ0GrwgfZoHY4H/Jog4zjJk/xg20v6/+
	 Fh+0WeqwQSnVHrouf3rTzFi0XC0Y4urTYga7ZYCtxqIOncQ2uPmptLwZwKA2RQU33UKyp
	 +LuReeyIs6xunMD9Il2mUq1Dr0NTJgnBkvngMoH5y5oTosPXDsH0CT6pszaoXdPGgKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793038726;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=hF6zy/Y0w18f+U5+lO+T+mBpU9y/36ue5olFOfJt/uo=;
	b=K5zUrr2mP0QcoyP+aGeXglmdxlwLotB2fILLWaJ/2r5/smvEW7V1mYP6q7W0CGBGBtNI
	 FO8nYa49IXqiepELO9ALqmCdbyUxzjtd3WWuBYEjjmNBbh28G6DvUokwOBmtwenLtzDwo
	 USTMjVtoEVEW9bVZNsW5wtRQbea2EKT5+2TyE+An1/DUsmF+uWC3ZH0ej6JJj5v386kMI
	 1ofnclrxJGO8B2DbQcSFK3VloGIayfGGZnyj8+R3ZHQZuNEI/Uvmn2cpfBIuB/LWtIkfb
	 ZtLm+csarOqisftrXNxvvcJbuirTDN/ZdCvXTqnbSBYErYmUyp2p5KmqeZyGrckIIEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9GnUFoc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1278606A31E
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9GnUFoc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2151F01828;
	Mon, 26 Oct 2026 18:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793038725;
	bh=hF6zy/Y0w18f+U5+lO+T+mBpU9y/36ue5olFOfJt/uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W9GnUFocgwsxd9FmECRmMuS13L+i3z/j/5i+ff/vMPfHNfN5P2uwHVuqthdn9HP/L
	 fIyKKWJNGHCuksVDuMKvwwh9vUpBY0N1KbHC9Y2dt0Uh+ozXHlEHfnfMfjCEyAFzux
	 6bthXZXG1RnQonjMEcs/M/RDrYaLHejEdIDVJZNyo+BEucPqzeVeAZtmGgyDlYKupD
	 RJh2XcDQoY69BxDkPtnQX22voeppBJSHfwJSFYB5WLPbUuuFQDMtl0ct0tcswfYgHK
	 S1gmjO6TA8izLPdb34wJRY+2HnHo3sarTOikw0TWEKi1BFk20HbtTFdB97nb5ji2Ks
	 rmZ0TffR5xwZw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id 9A5FC198003A;
	Mon, 26 Oct 2026 14:18:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 26 Oct 2026 14:18:43 -0400
X-ME-Sender: <xms:gZnfajZ-BHts4MBHXWFnW-gFp81JJN1vpJiEKvdsdfrbKSJhN8knDg>
    <xme:gZnfamWIQGYuHM68Kd6jnmjPguLYksU5g4Jw_AddnVo2gcvKZ_0da_c7maXj23Hof
    _T8rAAC1UhevvlnBddDZKe3O1kxHrTrd4SMmYPOc2HfZ9Ew74LqzJnbcA>
X-ME-Received: <xmr:gZnfaucQ3h9h4FkGosoq6ov7rhDK0QujE015HThBnfJxyGvlZYeJK4tt-sA>
X-ME-Proxy-Cause: dmFkZTEC6jaU8WSvdlYj4erYp5aRUyJbFL4tgzgG/uQqFE4vkk2Ztkn6i+N1Ul3PwjXj5u
    D20bYcJ5jjhuGT8nryltaojXVsoT+8ZOnEMBt9S/7aS1YRSG7dsokqX+kHK4DEBIg4c5Eo
    5xlUdcBx/qw2dml5xc1tuTg/O+U3f6ne+q9J03Y2b95iSFa8NrzvpAM47RG8hhktz73InX
    SFDDxM0RUNrTg8iD0m2U31nVOYGD5BcF18/dItqb/iD5FcOTNFNOOeEgPKogiCBuWIZfgV
    iI1kRdoA4bLUgQZcqKXElpW7HW7jbsF9gaHt8mu/7Ht6wXzutN6KcNIZflodDM92pgq5e6
    CLBddXVbonCCpdm9uNlwGyShwzs1vPdX853BI882TVLTvRSFRDEjJyE/oZEeo89hKoY6Ut
    sRPvR0dpJ+IZx6OBXXpX/u99FYSgbXkvjNzjC7a3sq7f3ATNFPFo22uZZqB3nmQWJC0oHf
    dUpW1W+mUrrtc7GaGQUQJxeFY/+0Mo6LEObWdXzJ6bOm9LLFMjGJq1YmfF5flTd0iuaJku
    fLLV0X8YfRAppyG4sYKpGui02bQvVMr8lCIOBecMZVZTmW8q1HDHnIdD6nME48ZsPCN2Dx
    3kGIVDkAlPbzvruiVEZcky8DfF/YWgAoeauu8l/u2z/YFRtQh9ishjxf3Pjg
X-ME-Proxy: <xmx:gZnfajPNjG2RbHJxB75I-_r715n7cKOjptqf11wBj9HCFJW9PnwwiA>
    <xmx:gZnfamKDG1lQgXhV-HyfW2-wrvQnTb8NGhOkgAakKn6hIvmKN05Nwg>
    <xmx:gZnfapkOYsIM1ZxSuCF8K8UHrW4QN15-y51cOf1JB4A5lBr2FhqhCQ>
    <xmx:gZnfalbT2k_iMvQpQnfHXYxI2Um8QTaZNros-SDUE7Kl1JVTGxzFrg>
    <xmx:gZnfaohu9Vkucs2pLBN8yypcdtfw3NWKeOnFysRWS4miLEyctDXIPwEj>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 14:18:40 -0400 (EDT)
Date: Mon, 26 Oct 2026 18:18:39 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Hungyu Lin <dennylin0707@gmail.com>, willy@infradead.org, 
	hughd@google.com, baolin.wang@linux.alibaba.com, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] shmem: do not extend i_size when no data was copied
Message-ID: <at-XtWBQg3jv3H8Z@thinkstation>
References: <20261025164619.89992-1-dennylin0707@gmail.com>
 <at9xXRhD2xZhszEj@thinkstation>
 <xmp7ni65vbinfj4j2baisrhp6xzro3asbepuq7xp3mvx6maptn@r4dnoj63uw4t>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmp7ni65vbinfj4j2baisrhp6xzro3asbepuq7xp3mvx6maptn@r4dnoj63uw4t>

On Mon, Oct 26, 2026 at 04:48:58PM +0100, Jan Kara wrote:
> On Mon 26-10-26 15:34:08, Kiryl Shutsemau wrote:
> > On Sun, Oct 25, 2026 at 04:46:19PM +0000, Hungyu Lin wrote:
> > > shmem_write_end() advances i_size to pos + copied even when copied is
> > > zero. A buffered write past EOF can therefore extend a tmpfs file
> > > without writing any data.
> > 
> > + willy, jack, fsdevel.
> > 
> > This doesn't seem to be tmpfs-specific, right? I see the same with ext4.
> > 
> > simple_write_end() and generic_write_end() check pos + copied the same
> > way, so filesystems that use them through generic_perform_write() are
> > affected too.
> > 
> > It makes me think maybe generic_perform_write() is the right place to
> > fix it. Hm?
> 
> Well, that would be nice. But how'd you like to do that? i_size update is
> the responsibility of ->write_end and we have to call ->write_end if copied
> == 0 so that is undoes what ->write_begin has prepared.

Hm.

A zero-length copy only moves i_size if the write starts beyond EOF.
So we can bring the prefault back just for that case, before
->write_begin():

        if (unlikely(pos > i_size_read(mapping->host)) &&
            fault_in_iov_iter_readable(i, bytes) == bytes) {
                status = -EFAULT;
                break;
        }

Overwrites and appends keep skipping the prefault. It is racy against
a concurrent munmap(), as it was before 665575cff098, but that is
userspace racing with itself.

The per-filesystem alternative is a 'copied &&' in every ->write_end.

And generic_write_end() cannot take it as is: generic_cont_expand_simple()
relies on a zero-length ->write_end() extending i_size. So we need some
replacement.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
