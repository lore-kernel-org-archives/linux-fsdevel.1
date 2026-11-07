Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071111;
	b=D2AOeeI3b4gdmsp4X/OTQU0t/gygGWYj3/OYD3aQsfYdK/9zqy5AiKvicJW9WHZoRJSI
	 UfTdtWjZ+MbEechor/LUestC9n1PIzL+IN69WytMEgFfLoEbM1yq8iWkZq8QyOmaf2XRD
	 LyVVIxLQJC464hRw2Z3TrO7RoEJqXxffnDvz+SPF0CtuX/fV1b3xb74gpE9P5brHTHvbY
	 3DRmV/0mfv124RZbo17p7sjyv2YDgZrsRtcngfBVvEh0knh1xvZvpYAwDggigtktvhbOh
	 ELk3drxEU5Ft+fo5BcwPz3DyWUnAIK+hRXTgSo0WV1x0y9pBH+0LGP3cdhQFIru2REQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TsrMgj6bLCNF471e8BX5RjLkU1AefdOx5U9fzWvZrc4=;
	b=e+utIQcGehU+ntWh1812S66TEeDk08ZktiZB0U40L6C0+/hyXjrIv/uoTIGDg3MOjf/h
	 lX6jOQjkdeJg8wpdosvSa8kAc+NXQB67mRxgJwOdssbyVkL4x1pCRuRZN/sLVv3EuZx9n
	 /ldwpwFFVuAemKW2DXZP3QG3n9sSNPPO8I6KyybE+lHELYknHsgQ3WFln1P13oWrTcf4r
	 ZW/XkmGcBizvoyo+B71qJftgoWZGb5V/U5qgudLC/2nrJEEfBG8zWzaNSOMkeeXjUgitb
	 jSKkilazKt1ZFnGfz6F7+02Vo+SXQytHH7pRyEkbV0ap/71P7Tvk9av24fwSW7ap0gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="rCG/Y3xW";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEC0606A32C
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Nov 2026 17:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FEC0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rCG/Y3xW
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so18277295e9.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Nov 2026 09:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071109; x=1794675909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TsrMgj6bLCNF471e8BX5RjLkU1AefdOx5U9fzWvZrc4=;
        b=rCG/Y3xWsXwF3I7/WqmNdD2VWITaJ7zv82Ec+WkPrhN/Q2HaVvHUxVY/JRnNWwp2gG
         t2IM3nP2WVJb/5tRx4UhNOl6sUqH6f46/8hnutnn1utJwNeb5mANRYu5xglM7K8u1gZr
         S1N3CWKnC9LKfCD8uixV/BONkwInAg04IPve8V5MAkSY0H/9IkG82BNKg+SOVgrvxThV
         hp9qOCAPZakhUMKT6HUSHF200IB34nBhFo32E2Yk7nDdJErj4LWu0iDb9uIbRpxtp0h6
         hUDQ5I19byCZGT3HCxay66tKC1QL9KiiVgLEqqWDmX163jYh2Aa/P/AbMhjVWU9NLo2p
         LuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071109; x=1794675909;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TsrMgj6bLCNF471e8BX5RjLkU1AefdOx5U9fzWvZrc4=;
        b=bsQ2kzAoVG4oRW0P+MEPR6PvvW71+IEGWnCX7LT73+rAzoIxWCbzR8Z0mSl/zYUp/e
         haUJAc04W4h0Btf3q3ogkY9ygnq1Fep0QUeqKw16nfSsOWlBwzBHMstZPVnhdVrPpIXQ
         jq7PUSbZ1VTyzajrxmyOSJ8RTww5I2wnT20uHo/uWhJX1W2J4QrFdu69HW83Z6Sm1rxk
         S3l3Ey1n396AiBfWD7jP4yf56PFxi+AV4d5vG2QDvbNuCQmoRh2u3oOxjaexng6lP57v
         +HO0T52xMdqEwpGrASeN/UrD+z3J+1wWoxX0YFY0rswQpQ35moIaYjiN3AhjW5J5dyeR
         IJAA==
X-Forwarded-Encrypted: i=1; AKwUvBwopqQkVPhMdoccUA52acXS312iEG87Bz08AdHuLWVsfw2HmKsELu402tldhoxZ+GSOdZG8yGotTnVD1VrB@vger.kernel.org
X-Gm-Message-State: APuU4Z9skuI33tE3fFpwatfGb1Pj0vBTDyGbEYe9PMtX7AYX59n4ywMp
	hyzZAacTSWz8mrt+iGM8ftEM4VHQldomc9SjcY5hZNvf6BjvTpzE5Zil
X-Gm-Gg: AYBFou0b+OkHenrGDTKc5VUx7epgTZaRs4kU1gwyvrXaoABu0fIKQdmJ+EmTdpDLwyJ
	Mx7SOZj0fkeSkWCgG6DqaVIQT/z7hcK9DKT8cFIN5LiNm0GPXt2nXQi7pG50eM2XhjoLBN3TcGR
	etoKRM5WfcCs3NOs9cie8gzGXY1mF6amlZKI04VaR74jWiuViJwzM8c/UxokLl0fH6BO3V/I49z
	WyfAhyAdFP7a+Nhe5XMvQFNtyxw6advLezt/X5JN1Z2NOS1JUzpnugaG5X+TzQSScBOFyVzNlnC
	DBBKDMzougT9go7bcMskV5dcl00sG2GCY4Vc+FBW3wAY0DI7qus+3d918mvytLRFuEquT6t8I0P
	DVGkB5JHR0fn2xL/hc/lp7EDgqbyshCtnKG/vmCygnOWpTaV5jd8vWkmjEjr+eGLEVpvEeS/fmS
	RpdeiV3zG/DTdP3ckniVvZ64AUdMCxMvQdZ9KwbAd2aefDNpPGu9Nnb7aJdkSUYYE5VNZiHGIHI
	GRNOcEjcDEnZxwKXj9ZNvd2NDlZvrUpQPjLxzKZ/7yMu5wqTYtUdl7TN1itAXPTMUT1Zxvax4qA
	J7N/KJPL0PyNXkc19lERtS2y8rc7XesTtl/P7BTlx0U3slR79OkFygQfZ+33qEPL
X-Received: by 2002:a05:600c:3f0e:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4b6db0d060fmr107153375e9.2.1794071108761;
        Sat, 07 Nov 2026 09:05:08 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e329153esm94149515e9.14.2026.11.07.09.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 09:05:08 -0800 (PST)
Date: Sat, 7 Nov 2026 17:05:07 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/39] sysctl: replace overloaded extra pointers
 with typed bounds and context
Message-ID: <20261107170507.0d66cc2e@pumpkin>
In-Reply-To: <au85ISJ2qUsB7y-6@hobbes>
References: <cover.1793204511.git.wen.yang@linux.dev>
	<20261029105837.2f8bee67@pumpkin>
	<0316f664-d98c-43be-92af-13c30436727a@linux.dev>
	<au85ISJ2qUsB7y-6@hobbes>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Nov 2026 16:27:39 +0100
Joel Granados <joel.granados@kernel.org> wrote:

> On Mon, Nov 02, 2026 at 11:40:40PM +0800, Wen Yang wrote:
> > 
> > 
> > On 10/29/26 18:58, David Laight wrote:  
> > > On Thu, 29 Oct 2026 00:34:39 +0800
> > > wen.yang@linux.dev wrote:
> > >   
> > > > From: Wen Yang <wen.yang@linux.dev>
> > > > 
> > > > struct ctl_table describes an entry with data, maxlen and, until this
> > > > series, two untyped misc pointers in extra1 and extra2. Those two pointers
> > > > have accumulated at least seven unrelated jobs: a fixed bound, a bound read
> > > > through a pointer on every call, an object or namespace pointer, a small
> > > > integer cookie encoded into the pointer, a lock signal, NULL standing for
> > > > "no bound", and a value the core itself casts to unsigned int while
> > > > validating a u8 range. Nothing in the entry says which job applies, so
> > > > readers infer it from the handler, and the core gets it wrong where it
> > > > treats extra1 as an unsigned int.  
> <--- snip --->
> > > > (~574 new min/max initializers) instead of pointing at constants. The
> > > > sysctl ABI is unchanged; the parport spintime minimum is corrected as
> > > > described above.
> > > > 
> > > > The cost is 8 bytes per ctl_table entry on 64-bit (56 -> 64) and 4 bytes on
> > > > 32-bit, because priv is appended; the range read path gains no indirection
> > > > and the migrated entries no longer dereference a bound pointer.  
> > > 
> > > Can you remove the little-used 'priv' parameter by making the extra
> > > information just follow the table entry (nested structure) and have
> > > the relevant functions use container_of() to get the outer structure
> > > and extra values?
> > >   
> > 
> > 
> > Hi David, Hi Joel,
> > 
> > I reworked the context side of the series so that priv is gone entirely;
> > and the final tree has no per-entry context pointer.
> > A small helper recovers the enclosing object, but it needs the slot
> > index from the caller:
> > 
> >   #define sysctl_table_container(entry, type, member, index) ({       \
> >           static_assert(__same_type(*(entry),                         \
> >                                     typeof_member(type, member[0])),  \
> >                         "pointer type mismatch");                     \
> >           (type *)((void *)(entry) - offsetof(type, member) -         \
> >                    (size_t)(index) * sizeof(*(entry)));               \
> >   })
> > 
> > The reason plain container_of() is not enough is that the core keeps the
> > table as a contiguous array.  For
> > 
> >   struct addrconf_sysctl_table {
> >           struct addrconf_sysctl_ctx context;
> >           struct ctl_table table[];
> >   };
> > 
> > the handler receives an interior entry, and
> > 
> >   container_of(ctl, struct addrconf_sysctl_table, table)
> >       == (char *)outer + index * sizeof(struct ctl_table)
> > 
> > for ctl == &outer->table[index].  It only returns the outer object for
> > index 0.  Passing the index explicitly keeps the original registered
> > entry usable:
> > 
> >   static int addrconf_sysctl_forward(const struct ctl_table *ctl, ...)
> >   {
> >           struct addrconf_sysctl_table *t =
> >                   sysctl_table_container(ctl, struct addrconf_sysctl_table,
> >                                          table, ADDRCONF_SYSCTL_FORWARDING);
> >           const struct addrconf_sysctl_ctx *ctx = &t->context;
> >           ...
> >   }
> > 
> > Shared handlers get one wrapper per slot; the common body does not need
> > to know its position:
> > 
> >   #define DEVINET_CONF_WRAPPER(attr)                                  \
> >   static int devinet_conf_##attr(const struct ctl_table *ctl, ...)    \
> >   {                                                                   \
> >           struct devinet_sysctl_table *t =                            \
> >                   sysctl_table_container(ctl,                         \
> >                           struct devinet_sysctl_table, devinet_vars,  \
> >                           IPV4_DEVCONF_##attr - 1);                   \
> >           return devinet_conf_proc_common(ctl, &t->context, ...);     \
> >   }  
> 
> Two questions before seeing the actual implementation of this.
> 
> 1. This means that we will have to add more macros to the sysctl
>    callers? There is a clear signal in [1] against overuse of macros.
> 2. I understand that you are doing this to avoid having priv. Is it to
>    save memory?  Yes. priv is a void* and we are also trying to get rid
>    of these. But this changes removes the use of two void pointers and
>    replaces it with just one.

The idea behind removing the 'void *priv' is mostly to save memory.
There are a lot of systctl and hardly any need it.

This solution does look nasty.
I suggested another where the size of the array entries was passed in
by the caller.
If that works it would allow the per-value function use container_of()
to get extra fields.
That only really helps if only a few 'private' functions need it.

David

> 
> Best
> 
> [1] https://lore.kernel.org/CAHk-=wjUmLrJd4KM4xvJHUN4P0r8oSu5LyvG4JipnhxizBrE9Q@mail.gmail.com
> > 
> > Single-entry tables simply use slot 0:
> > 
> >   struct devinet_forward_table *t =
> >           sysctl_table_container(ctl, struct devinet_forward_table, table,
> > 0);
> > 
> > 
> > The series is 20 commits over 134 files, with no priv at any point.  If
> > you would prefer a different shape for the helper or the wrappers, I am
> > happy to adjust it.
> > 
> > 
> > Thanks,
> > Wen
> >   
> > > David
> > >   

