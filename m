Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB17318ED6
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302242; cv=pass; b=h9XImcuKpc6PK3+6mbijzhstTMmSRb6nx1LaoWkDa0Wh7Lz0iYhbbbrkudzLiCDLNlfMCv/kSpid/7HrVL+BVsdq2m60Lc/QfW6YqUSl8IPU9SWi769Zl+ZfzuMV5MxoxafGJecX9Gq4YlRE6lJ791nXdtc83fsQnH4eqkG26uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302242; c=relaxed/simple;
	bh=y/LFi3y7kc95Uv4v2AAQjxLkBG+5TUnXboq929xWwHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Td6NvEwq8qhwV+ZNx3lW1XdlWFg//ghFeE9Ke/Q9KVnZ/EHmdaJmCBY9KpxqmxPo28ePitOtOjdamxhJ44C4nciXQTnj9mCk75JkNVPo7gzmm+P74yFIsPrvpRy6CB0X0fQfSM2CQyHNE+S5D7cPCQuIAN1VNSxZjc4/Jv1FEcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q916H6ly; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q916H6ly"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bd8f9889a8cso548456566b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 11:37:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779302239; cv=none;
        d=google.com; s=arc-20240605;
        b=Zg769FXNdoDwA5tz/E9kag58MUZFvrAJm3I/psxgwqSVNtRTC6wfyq8I6jKbpAP1Wg
         hAGAkdUHOdWawaUmV2gcnQpvQGzbD61XZMK0bYbIeaOUmr2g3NlT2oENw+Z0vZIjDE4u
         h4LS9HKhfjo7YaoLLzAGIyY994G+FGfaGo00hGQHEUkk64boWGqzPWsg6yN0L2B7alra
         xVfDU2pYVHzZp3va+JeWxn6hm9nmfZ+NK0fUkdeaSl9J1hGhuoskbmgBI85wPk6RNuCY
         AU/kGctgZ0xL/FX9jGhIK69+PNfCofLwZLuR28hZw4m33l/f+1FaFG+oeVtqFmToP9lY
         195A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rkEbuL2E3uSBlTv55+RGqb0HN5P/1ASfL2+9WUvrtDA=;
        fh=JwwrIMocSr+TwMK46I1myW14qWx4HmLtxGKZBc2tv14=;
        b=VX6q9O8mcjWgm+Oo0YYXDtWzcyuEOWr0J9Ym2a6xxm9GuHmKb+91CXc9id+1nndM8o
         sg9wz0cN/twSIHefiIjUuYPpYW/bA6U7U/5lll9oNomaYbE6FiIe4+IYKYq7uDT6yHjh
         GKRd7I+8ajfHY8DZ/84bhGfq1KZOjMg5j3XnTJwCbdMROXUsuxTJHVX3qIAfxUi1PLrY
         ePOaPXY3896sNPgBFCSnxl3AT4XF7OKaNNxfozscyS8OeV5Gb6PnZlb5uUu6jWVF/+EJ
         5GxS3Xzs66A11UkfyFIkuhxwX1bhFHvvCdPejCEKn5xqL9pF278e5RRBDww50HHIgkGr
         vYgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779302239; x=1779907039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkEbuL2E3uSBlTv55+RGqb0HN5P/1ASfL2+9WUvrtDA=;
        b=q916H6ly4SGxwgAhudil09o6E3NC8QMAgSrbmaqrYvPDh5CQPFBmSmVkrP7NhxeShA
         +zOfTcd/sDTbzlPpA/YkLb93v0VOI4zPoQGIh81CVyLT9b7tjn0DhqBKCovlWcgpUqNb
         ZRyIEduNdzvovTIArgj7d2ttDU2UjmiXker54UKtWULhb1fGUxGDRx4RguXvpi/IR190
         KZ12VJ4M7W2m7xY/LJmrT8SSHR/+cK+T6lCEdyWKDzTV7J54VgE3XJrzbXDycoxGOmRK
         V+iEJnBbMeyTkqqExKQNQBwQvKKkc+s1mnUFZqcsp5K7qSxrivvCi+88dLW8HMkk9JiR
         4hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779302239; x=1779907039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rkEbuL2E3uSBlTv55+RGqb0HN5P/1ASfL2+9WUvrtDA=;
        b=JvZOBfbhFZLgXPQvY9BcZOoHA+JSdKIfXTjvSdqEGYbmi5ZRSBSqO82+gKxbdiZBGF
         7NrYpgiVjxeO27bmswZXPdxEYnO4cGygXWJz12qGHAONGMKFle/C3eGmgOfeXQrp3JBN
         8UCayNSNjxKXcq5QPQdzd2blpl0/MZbH56K0f48W1WPBYlGdfolaaF+DqcmcrvcMhey3
         SQU1ii4A7VyCsVwpuVW9H6PQnGx2Gz9OHd1EU4nSevSp6U84b/1YzpAU2KE1DkWSSz1J
         3vZue9TnuEs5/6BxyYE7E7xDWMmDOApm9e+rXj3FG+Vyy/ySr7S3RKOLUALYF241rsFg
         SQkg==
X-Forwarded-Encrypted: i=1; AFNElJ+yfc9SRnQYdB21i4GXWybFMCOQFSz4M7o6ct16gK/XausurxcYof4v8NUWETf/r2RtmT5B2i2W/8qOMdHi@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4XSvZGTpY47/47NUuiUedn3E4jvlnZD0iJQ0q25PlEzNwq+yn
	7Q55GA1Qoy9ORuGRq1k6nMMJ6OVIuzkPi1vnKhbq55NJXKhw4VSyeGtolFCPe3HcExGBu/ZJ+mP
	AiMjarZDGXkiuaaQqUTF9BtlvEIwuwnxftyrf
X-Gm-Gg: Acq92OHI63YAXlb1JL2LOLSKZPW505xWUH0W9Cy9w6P9Y6d0o7g6mfBRY+YdBqsDWzc
	gkGvdkRluBR0dT1RRgOcO6T6zEP+7uYBCwp2cC+oUsNoDQc1me4V2C+N4vH9obTQW8QjT1iuPB2
	ovHRrE6oGzz9cE52u9A3/q/+km9Kgiyp4gwAC7JRcC7oiBpN1r9A7t0GdHe1Vew7tuBZ8Yos+OJ
	XOVUAwjBTuZKV92vEwVDXAqmTNegssfuuGnjvsMW8ub39ok66xpjgXC2Nqiu2Bo4A9J5DrqlQMS
	y12c62/X2rhjUGwJniY+jFyrDqsJ+NQHvU8yvB1jmg==
X-Received: by 2002:a17:907:c248:b0:bae:8734:18b4 with SMTP id
 a640c23a62f3a-bd5177ef45cmr1537838666b.16.1779302238792; Wed, 20 May 2026
 11:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424170503.2096847-1-amir73il@gmail.com> <20260424170503.2096847-3-amir73il@gmail.com>
 <2gnaoibhljk7a4f2lwri3ovyrfydld6kqyzmjmcwekl2fub24o@dfhdjc2vzsfj>
In-Reply-To: <2gnaoibhljk7a4f2lwri3ovyrfydld6kqyzmjmcwekl2fub24o@dfhdjc2vzsfj>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 20 May 2026 20:37:07 +0200
X-Gm-Features: AVHnY4I4EGUtGOuxyGOhP12o5dCcLILBMSJfvdWMrJJ2cC8ltj-nkDXh0eoC1Ao
Message-ID: <CAOQ4uxiY+CG9Y8rf=349jwsOtL_XckV0nzT0j3+Zd08wMdoFvQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] fsnotify: introduce fsnotify group types
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 11:13=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 24-04-26 19:04:55, Amir Goldstein wrote:
> > Currently an fanotify group can subscribe to events FAN_MNT_ATTACH/DETA=
CH
> > only on mark type FAN_MARK_MNTNS and IFF the group was initialized with
> > FAN_REPORT_MNT.
> >
> > Hence, mount events can not be mixed on the same group with filesystem
> > events and mntns marks cannot be mixed with filesystem type marks.
> >
> > Define a new property for an fsnotify group called fsnotify_group_type
> > which describes the category of events and mark types and use a distinc=
t
> > category FSNOTIFY_GROUP_TYPE_NS for the mount event groups.
> >
> > Create helpers fsnotify_is_{fs,ns}_watcher() and the macro
> > FANOTIFY_NS_INIT_FLAGS and use them to generalize some code that was
> > checking the FAN_REPORT_MNT flag.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> ...
>
> > -#define FANOTIFY_INFO_MODES  (FANOTIFY_FID_BITS | FAN_REPORT_PIDFD | F=
AN_REPORT_MNT)
> > +#define FANOTIFY_INFO_MODES  (FANOTIFY_FID_BITS | FAN_REPORT_PIDFD)
> > +
> > +/* fanotify_init() flags to create a namepsace event watcher */
> > +#define FANOTIFY_NS_INIT_FLAGS       (FAN_REPORT_MNT)
>
> Seeing this and where FANOTIFY_INFO_MODES is used - FAN_REPORT_MNT does
> influence the set of supplemental information that's provided with the
> event. So IMHO it should stay in FANOTIFY_INFO_MODES. We should just have
> bitmasks (currently two of them) through which we decide the type of the
> notification group we are creating.

Makes sense.
I might have had a reason to do that, but if I did, it needs to be
better justified.

Thanks,
Amir.
