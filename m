Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E0A3B6C0E
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773417629; cv=none; b=DMF6Z/NS3MJVTOJpr6OEJdX/pvE3emaPn5Rsrf3fk9b0K5uatrNycy9MgP25DP1kA+GWr2J3zeerqfF/I04O1+2lzjGU709r83e21cJJKi/87d1tiZLQUE8ESPHHgT7njMSku7dEYWrQUi068a0hsupUChKDCSgUDv9BND1Tguo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773417629; c=relaxed/simple;
	bh=kkUJVfal9a5zY4xjgKOYtOSsjHbZ/D7+yBsf+FBnTaE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=CMJlOXkBKh+1PNMefkaqqobdToesGGOP2ILVQJVtFZIC/GPA+w/5Zv6SSSJ5aZNUxbm/wWBeWX7UX9bj5TOrptckOi3uBMTU6xfu4qEnPGar+AKqfQ4P5ElNAsBw8f7Xy1kEgAyQRhyg+7CT8GYshaeX02sHBhFu3WQJ4+6Ij30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6vUJoyV; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6vUJoyV"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6643a90c603so876619a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 09:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773417626; x=1774022426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkUJVfal9a5zY4xjgKOYtOSsjHbZ/D7+yBsf+FBnTaE=;
        b=j6vUJoyVVyXKaY/L4tnW2/8iqT0BGGv+LOLlms26SSTiNDuhZX9YLyQIfT8lA4sA9F
         YBuo5Hd+XHq4CLR7T+kHFe+A5c5mXnlvmafz3p68aSMb/00Dq8lkpmADNZ9Ud8cjzfya
         psOtvUjGQBTYtAs7JtA9U1A5AIybyutyvo93P4HPR7+ejcZIxSLvwClTbhRLOMNwSUOP
         98w+cuc7+BRnNxmepoz+HXduI/+H9rZhW25GE6Dl1lIQaLpjzDSZm7P+1M7scBgTY2yj
         WFvZPYFEkaVVdSjvJw11AhGjcv8CZ23WYmZghzisgL2Sg4RlJQi4uc6t1hdlhHoiP5lK
         C3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773417626; x=1774022426;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kkUJVfal9a5zY4xjgKOYtOSsjHbZ/D7+yBsf+FBnTaE=;
        b=KE0mgfvOlSVW2STjuGamDrw/WAbaDHAjEQ7ef946lzT7ho8WPNiOMV5HtEURlofg6+
         lpuMKbk6RyG4gTaBxWLaTUP0FkgXKJeJtthfqQgfJAgwVt/nWz2Lb8gmzWMmJonjIZlH
         vTYPE4f6Uj4AG+4qdaX2nyZFsrujSRwicTTts0w4aa0cGU+YVS7FVCVHBANBJHAAoPl3
         F1+4J74BXmelrUoCGEVL6Ho7V5aRwqJIAq6GaXIa7n+L9KTHxF1CF375TbXYCLCIAOXy
         nsRi6zJv6HzhUxgJ+9WnqAd5mTSomvOqj6K+mXby8sPAGsFCKE+w9KAt0FQcsEPsfchd
         8tgw==
X-Forwarded-Encrypted: i=1; AJvYcCX0NglyyA77w1DicBTVNuaomQn6dhsEdd+IpmhsukrC8Vw0C4GAglEwWCivTAoNLlFZtSLM1RtEZ9UHHQJn@vger.kernel.org
X-Gm-Message-State: AOJu0YyxctFNo0gHpweuWs3yllLk4jdziPlEpxtwMyXnSuLQ8CEh9FOl
	CzfzqduJeEbW4iv9UmK21i5VcBKv5+nFV33N9WMxPP+LNkROWUdSpAw/
X-Gm-Gg: ATEYQzya2yWbPPh2oOAslcgN471btNv7plYw+sLuyXJWVyqHF0WcWkSeFW2q7tF0YIS
	Kdx/zIbhfPhdftDksojBim5pSgKzkdem4V6JpXagjXORRDAEGe+fGqzepiK32TAahR6vXff0yKe
	+VciSXXOUsaJeL2X/IfoUwM/vFSiyjocFO24Z5iDTd0DLorZ9iI74RoOzarzWZVxjXAnNp1Gnbc
	s/dxSrFtN8JKGBq411e1vZcOvGLOVKFpQH7zGo1peNcM8J629kN1rH80+IyfKjsBldV+qSf/mBT
	96LpOTMAX47VN8ft8YkFvOXaiWTAId8OdhVMgPWOUwkpp0MxeYpnimPaH0urOIcP7bjrzXoe59z
	6hX5BjCmmfXncm3tId60BST8bsytNCADHTq5ORonbtgD1gKFmmeLx95nSQLmVZZe9nxL+EUs2qT
	S0U+oj4CkUt20yyDHnKJp8NI8nzg==
X-Received: by 2002:a05:6402:254c:b0:660:bf7d:ce58 with SMTP id 4fb4d7f45d1cf-663bac00405mr2053678a12.16.1773417625993;
        Fri, 13 Mar 2026 09:00:25 -0700 (PDT)
Received: from ?IPv6:::1? ([2a00:23ee:2968:8e13:3055:679d:b1a9:b589])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66350d73f14sm1374845a12.30.2026.03.13.09.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 09:00:21 -0700 (PDT)
Date: Fri, 13 Mar 2026 16:00:17 +0000
From: Josh Law <hlcj1234567@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Vlastimil Babka <vbabka@suse.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Josh Law <objecting@objecting.org>,
	mm-commits@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	"David Hildenbrand (Arm)" <david@kernel.org>
Message-ID: <8bc3ea9f-4e56-4e41-8cf6-97e3b5a45b31@gmail.com>
In-Reply-To: <e2278198-22a4-402d-9179-c7cbbb186d5a@kernel.dk>
References: <20260307221931.2848601-1-objecting@objecting.org> <3cd25de5-3737-49f4-aa8b-eaaee471af50@lucifer.local> <ee644e1b-5759-477f-8aec-35c91a5a938e@suse.com> <20260307222154.2848660-1-objecting@objecting.org> <667b75ad-bce9-4997-8ebf-8077952c2797@gmail.com> <20260313-anvisiert-gemeckert-352414e3d58d@brauner> <20260313-halskette-annahme-94e782eb4ae4@brauner> <01a6bbcc-1442-48c7-be5b-14f07fe655c9@lucifer.local> <28175752-2775-476d-9485-499335a99aea@gmail.com> <e2278198-22a4-402d-9179-c7cbbb186d5a@kernel.dk>
Subject: Re: [PATCH] MAINTAINERS: add Josh Law as reviewer for library code
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <8bc3ea9f-4e56-4e41-8cf6-97e3b5a45b31@gmail.com>

13 Mar 2026 15:57:04 Jens Axboe <axboe@kernel.dk>:

> On 3/13/26 9:51 AM, Josh Law wrote:
>> 13 Mar 2026 15:48:32 Lorenzo Stoakes (Oracle) <ljs@kernel.org>:
>>
>>> +cc David for mention
>>>
>>> On Fri, Mar 13, 2026 at 04:33:49PM +0100, Christian Brauner wrote:
>>>> - first patch Feb 28 under pseudonym "techyguyperplexable", switched t=
o "Josh Law" only when Andrew required a real name
>>>> =C2=A0 in https://lore.kernel.org/all/20260228114939.de7d44de38d907a9b=
6632480@linux-foundation.org
>>>> - 142+ emails in ~2 weeks ? 37 patches in a single day (Mar 1)
>>>> - All trivial/cosmetic ? SPDX headers, comment grammar, spacing, const=
 qualifiers. Zero bug fixes, zero new functionality
>>>> - Carpet-bombed multiple subsystems ? lib/, arm64/, staging/, input/, =
etc.
>>>> - within 1 week of first-ever patch, submitted MAINTAINERS: add Josh L=
aw as reviewer for library code covering all of lib/ (locking.c, iov_iter.c=
, rhashtable.c, etc.)
>>>> - Email identity mismatch ? From: hlcj1234567@gmail.com, Signed-off-by=
: objecting@objecting.org
>>>> - Formatting problems ? top-posting, line length violations, patches n=
ot applying cleanly
>>>>
>>>> So I mean, one week to Reviewer. Even if we're being very generous her=
e,
>>>> we need to do a lot more due diligence going forward. We can't just ha=
nd
>>>> out core components like this and risking our reputation and security
>>>> posture.
>>>
>>> Thanks! Agree absolutely that we need to be careful about this. Jia Tan=
 should
>>> be instructive.
>>>
>>> Josh - there's nothing personal here to be clear, this is a question of
>>> procedure and caution.
>>>
>>> More broadly I think we should avoid assigning new people to catch-all
>>> categories anyway unless they are well established enough to be involve=
d with
>>> _everything_ the catch-all covers.
>>>
>>> For instance adding people to the mm/* other than perhaps... David ;) w=
ould be
>>> crazy.
>>>
>>> Also - Andrew - I think for cases where you are the only maintainer but=
 it
>>> impacts others, you should seek acks proportional to the scope the MAIN=
TAINERS
>>> entry spans - in this case that'd be a _lot_ of people - but that only
>>> underlines that we shouldn't be updating such entries anyway.
>>>
>>> In fact - can we just do away with catch-all's and just make sure MAINT=
AINERS
>>> entries are established for everything?
>>>
>>> I have ground to stand on for this as I personally did it for mm, altho=
ugh we do
>>> still have a catch-all (not sure if necessary any more?)
>>>
>>> In the case of lib/ a quick fix could be to figure out which files are =
not
>>> covered by other MAINTAINERS entries and adding them all to what is cur=
rently
>>> the catch-all?
>>>
>>> Cheers, Lorenzo
>>
>> Well, it's already been merged into linux-next, I will keep constantly
>
> That doesn't matter, lots of things end up temporarily in -next and
> disappear before it ever sees upstream.
>
>> trying to prove myself as a trusted figure in the community, and I am
>> learning new things every day about the rules, and when you talk about
>> me making "trivial" patches, I also made some medium sized bug fixes,
>> yeah my start was just "janitor" code, but I will try to prove myself,
>
> I have to agree with Christian/Lorenzo/et al here. This is not how it
> works. You prove yourself by doing quality work, and then and only then
> does it become official. Adding someone after 1 week of a bunch of
> trivial patches is literally crazy, imho.
>
> --
> Jens Axboe

Thank you guys for the context and the history. I understand now
why my request was premature and how it looks from a security and procedura=
l
standpoint. I appreciate you taking the time to explain the 'Jia Tan'
caution, it makes total sense why the bar is so high.

I'm going to take the 'no rush' advice to heart. I'll focus on the technica=
l
work, learn the etiquette, and prove myself through quality contributions o=
ver
time. Thank you for not being super mad


V/R


Josh Law
