Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE21436344
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771825; cv=pass; b=jXMpdM3+Lx4bRTZVy0I/9bwUBVZnID/XEp8CQZb2kY4qNziHHUF9mtG4hvYx9yKQamEK9s2dGoj+N8JhKmmtUPpHvJuXf4fKQqmJD2uMbQwdvKLa7sDP0Bh3qxM5Y2izbc41wy7+ujpWlmHJGetlESdb892XS77gxAR8zu5HB3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771825; c=relaxed/simple;
	bh=dPEdLzpAoisLtNpVvndO8XrxUnyUO0mRm/pzuoHcv6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ged2m2mkm9yXox38t2NOLPOt4Wg2iuhPgHVJptM9owGfb3hmcb7MHRdY5UOY3ZGoN67JWuWzwjvzxexf/TNMCTDzR1gW34sR9DtFVf1kky7GsRr+nO6r1dxUyBaNyiycbIg5UJGQ1J195nEJI/DO5o6N960wZo5UhbZKGQ0Nq2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QogrGVwY; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QogrGVwY"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8f97c626aaso493215566b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 08:17:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778771821; cv=none;
        d=google.com; s=arc-20240605;
        b=CS1lYeez4ahuUPV/pq6uLupE14GSOQfBAwRaeEkiG9SbwC6Bth8vtt4yTZlkJqsape
         qyf+Y9yBpRZ2KOffZVScVxS5WCNBgYoJz/K1vltW2wwKFVuBk90Oz6ohp9bikN8sfVoZ
         +N47RP7LRSMk7F9naWpZKl2KySMzuSCLUqwOgN3XbME82lSlz+Grt5uSupYrDr6K1W1v
         9u+BNh+obCQoZhwvcntuFsutp97v3yrCWTeCm1dLtmoOdjzIEIH1ixNIUHKkglrC6KQx
         L8YriXLFDubM1z18ITGiRX511tDlJMixaRWcC1Obhib5NmftT80l+OY0e4SDpJHFsIk2
         yDYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dPEdLzpAoisLtNpVvndO8XrxUnyUO0mRm/pzuoHcv6A=;
        fh=KoUWOSR1EK2CdnWVh2kIizIt+lgr4E2g72JRlNXS/Co=;
        b=MDcHLgo50N6i2/P4gmRWGU+QNUXHcoHf1c9HmUJyJJ918+31EpCE4iho1HI3x7JrTt
         rFWlzDkJVl/HTJiGxzwVcC4V6jROS8Lkb2xtxG6qXXDl+AIrMrdKWLbM/9W1qqORKDa7
         fw8Rn3HOkMyOunSCYZGaJ29CURjsuYRfFLjtLIkCYaDlOhj0A3e5FljoFveEc0AfAE2Y
         lJRS6kAFrgKMhdwy3UpLmptSOd52viE+JhtEyx4URO/JmdC0BUam07koOQB/XarpMORX
         KhhqXIDfzDOHDGbQUerwmpvI7Qn3A9THhrcPUp47PrFfAn/A4YKJLuH3D9dFVq19i36H
         x3JA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778771821; x=1779376621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPEdLzpAoisLtNpVvndO8XrxUnyUO0mRm/pzuoHcv6A=;
        b=QogrGVwY1gn1xnrBUpn3/cnrp01fvNYLDTAsaEnKo6tPIhTD77EmemXbtRb8lIS0XL
         yG6zzwGQ3/7+SxTksvDzYpE7KNacDNZFi4a5KH0/FdFq7cRCEG9rAvY4TmV9DYAUG94C
         Ukm/ToBvWtYpitpCaIB1OZdb1juFjxiZMzkzDzjeKx1Nz0yhO85zlx/AIcgucDEj7vVL
         k/dAyaH5W+1VpHHOixrwk+GPM0AZQJTFVSxlj0toPiDyqVUaBukzWCNM0sJPLl0x+Olo
         CIi7VMzGNslQ2OK4O4I/bWpHUH4oEv5h8mkCUjH7k31kK05RCyUvxI7Bbiyp7Ty1dkXV
         uiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778771821; x=1779376621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dPEdLzpAoisLtNpVvndO8XrxUnyUO0mRm/pzuoHcv6A=;
        b=YK+5lH3vFnoiMKrYp5+O2sO0QvijHRHH9cxBfvt+gcmciwlmNvzKxJYtCkxnp6kh5V
         8qhm0uohjQopwczbwl7oFtQIgkSqFAAvCM5okPNlnbe/57AuVumNsDFV0OEu7ARABZIl
         UJ1RKu+h6/BgLvp3YRLEhdlSvbZKXmV4eQzyxieUvh1xRYYkS/XBKnQY1a1TR6c8hKEt
         MaJWlnRu9z3Jx4sPtJQQ2izUxWEOyg2fhSE7IsDy+j7l3GxmtRGHHPM1fm6iaJ6VsLQX
         /nljT+cEdvuKWYYcp2A+CjMP/dlIwappwZah0vFJpzdFPK+nYfGh4Y/XlXmW5UgSYVUo
         NaWw==
X-Forwarded-Encrypted: i=1; AFNElJ8q0yyCBSI8NSgUDpt9JVISa9S6/g0HgmArhFz3Mg/ESBswdoX4azEfyNrBQGeyKM0q3u4fI2RoDOBKhyoV@vger.kernel.org
X-Gm-Message-State: AOJu0Yx63ue6CZdufFbbkmVNWQTmBByWAtbwHaZnsiIiujWCUOxrBkOr
	fAVMyyaVvD+iJGNm8M3qwO5bv3ID4QJCm1ccwnAHkV71hKqMpLK2TL8AaTGtTXxfPpSnuHG3rtt
	VXbOwzfxMZVt+EnNt4yOM7ijxszfm/Bc=
X-Gm-Gg: Acq92OEb4+HEtP3b85mIVsr2EEMHoNl5T1yX6pTADrL5S7H9H+hQFZU93CWXugy71JA
	zCOE/YJQb/6yJ/Jc5IX4uQtuPRuk2Tj8CG9z9b9/NXA805JRBcHJXGoBI4JgXSvoG1AZUDi4/vu
	47vt7WFWAdQk15ZEG3pIRCe5NPZWUcXpF+nt7VM1jyJEQoLFmlVtJHmFqveSlRNYG5mozefx6JH
	g4GFgSKZ2Pw6z4oLJ409uJjYgs9awSghINKwKkFhPh++UvZ28BiRfkj/V5qr5ToNpMPe7EcqdlS
	MIws5X+t5gRCot0a/841ko8mwQ7mOHcbLSV/tAnWmQ==
X-Received: by 2002:a17:907:971f:b0:bd4:1bdb:1e5b with SMTP id
 a640c23a62f3a-bd41bdb3a98mr530768566b.27.1778771821338; Thu, 14 May 2026
 08:17:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxg+DkTuinnf9AMR6gdHqAydbD88+oBkTtQtABJfdC0vVw@mail.gmail.com>
 <20260514121336.439565-1-nirmoyd@nvidia.com> <CAOQ4uxg=gONUh5QEW5KJcyXLDF15HbLnc9Ea7RKPcgtyfPasTA@mail.gmail.com>
 <f9f0e951-a52d-4272-a44e-890d7e7555fa@nvidia.com>
In-Reply-To: <f9f0e951-a52d-4272-a44e-890d7e7555fa@nvidia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 May 2026 17:16:50 +0200
X-Gm-Features: AVHnY4JwoSSd2cEfirUZGC7RWx_G-jzc2_ansVS0y4dNwHY950Icyg1WXbaO7SE
Message-ID: <CAOQ4uxgRzcSCWWq=eGfSc=iUOs8k_eD1_OKCB_sh9Vc9nSQuOg@mail.gmail.com>
Subject: Re: [RFC PATCH] ovl: keep merged and impure readdir caches separate
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+a16fb0cce329a320661c@syzkaller.appspotmail.com, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 4:55=E2=80=AFPM Nirmoy Das <nirmoyd@nvidia.com> wro=
te:
> On 14.05.26 16:09, Amir Goldstein wrote:
...
>> Patch looks great - real root cause, gave you minor comments.
>>
>> IIUC, as far as you know, the repro never triggered the theoretic
>> OVL_WHITEOUTS race?
>>
>> It was always just this ERR_PTR(PTR_ERR()) black magic?
>
>
> Yes, with this particular syzkaller reproducer, it was always this black =
magic. I tried with and without your suggested changes and saw no differenc=
e in the crash behavior.
>
> But I think we should also have the fix for OVL_WHITEOUTS race as well.
>

Yeh maybe.
I don't like making fixes to theoretical races without reproducers.
I'll think about it.
Maybe I'll try to reproduce synthetically.
Or maybe I'll just do a fortify patch.

Thanks,
Amir.
