Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DF5547051
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790711004; cv=none; b=DtSQP0s9upc+AcH0Sx8CjmukLJgGyAQGyPs8If7UB4z72GlkwLv17eqNQezOZUejBA1Yzv7GfSJ1OtNIQAJK/cXi4vQZ0X9H/WzAs4bSjkkoJ9b6kKFsUIelXjaiA/Nza9O+e6lEL+EE88zTVjyG9WUEdh3xpoP3BUmuD3dKm8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790711004; c=relaxed/simple;
	bh=dBMYhsnGn/XX5swUZuYXT7fLE+iyooQ1jhUdEE3Ktjk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=P/9yDMb3w8fU7/RZvu7IAjJzt5KMbR57Cp2x1xZsGYmG1a7v7n0uqkt+HItf+xmkRHmJqYj5PmH/b52EsQP8xZzZwWReS/G+gpxEXfA54Lum5bl6ZWFJBvQ1IsVWiG5igrmDAB6Eps4VpEvZf06Cnb7k76GpL4tLVOqz09z3ot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgvT+NYA; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgvT+NYA"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4885d4825adso2796167f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 12:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790711001; x=1791315801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dBMYhsnGn/XX5swUZuYXT7fLE+iyooQ1jhUdEE3Ktjk=;
        b=IgvT+NYAvDBWT/9juow145l6NXdXyereFkfdjjkiWcwIlPNAdxJI4+mJc4sq+r/cly
         xsRgE5JSeBezMcMkmNEiCva3KBufMI5UydSGvUjcKso+Kxt/kgRyqYrvvy2dYCD+cZCl
         6AnfLCx8Go2VzHcMH9STadaQjnGnyj0Zshi9IRJ662cVGqIPo5tIhyzxX4FbCkWF48Iz
         0yelp6Euuk/+bfIwyuh+TbLZ/oJMzWrzlF/S+hYGGtp+mzYxLslFLxcEoRMc6Z5fIW59
         Y69yiPKT/8ENIuaogTzNvNyFII9GFDOpb+J6Dpc/UVB7Nvm3ZBeDLhnQZTH1spyRZYhd
         +RLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790711001; x=1791315801;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dBMYhsnGn/XX5swUZuYXT7fLE+iyooQ1jhUdEE3Ktjk=;
        b=FZ5ySgaA14fKzhG9NlLILkeqxM+DXYJTFrdtcUR/ydUHo+GSJ2nwzoKoKmgPCiXxG5
         2lXnIKnh/egUelaRXAOOUDU7Dp9e6MFRDH3MaBiqippmIha2zm9u85dHkVmdT0iicRKj
         CXn6LxPGkRGWsY4Sh1gIUop1lxbix1JeAey4AM63zl5HAp3nA1V/1rX/Zgo1PIg7No7y
         bpWGyhhXUg9Z0bK7sxK60C1a8npToBXVTI1rmfiaDTVTTPqrSYup5gtei9H7fCKduN0v
         DlYcERYHfDKRiPACkrX0rpntCJsPqGaNCVcinTn54n1GgF6E42Io2AUerkk2eQ8p3T8T
         mQMw==
X-Gm-Message-State: AFq9FYI50PT7EoDOlCy2pSSmPfOiPMGa1zg2TdUSkTzKunUInAn/7vWi
	jvXBSfycVuVIEnWfvvGOxRxf69RgMMtcr0MzOzN/2pEPo1FuS6dRd5Iw
X-Gm-Gg: AYBFou1iFyOgOVnQ6yroFGmgtzFnDw9y2kMAjU4v6fvkJbTb5WLjRn/RPofFa1pF5Wm
	4pSZpFaS5SMAS5N0UsZHsA0wyzIdWXbz4/tdy96ZfSTHuIQhCnpqo86fZozQBODTQwFAPaJZKBA
	3O8WWpDLrelDGDhYRsdwT/qgEYMVZ/zMAK0kx1ZI3qJ9IkHdNT2wYy4BEH6TRPBGElJcTmyAbhm
	ImrAO6qGZEYjTgSBKj6b8zFgmWJexAMMuElYAoAUGra3IVqiSgO6/vheDQjoRn/1pbLyEXhJRcJ
	IZz0pqeNUOeNFXz6KuIqDrCvc6iBi2fdebYYwmsIbA9GelksPAo4i8iHb3TzRtEjGSyk3BXcX2W
	MWUyPGuRXdxS6UnZ8aFBKltR8ufopRR8f3NXwNTAIa4dDzoX98K7ryO7VbsALEAHuNV+3FE80Tw
	IpGqrtF/jOm3ZaQL8PlBVjt4A4AG5oC/s8DT8zjbWOiLGT3o2t4qxrban4cxf8GKgudmkcve9CG
	Cw=
X-Received: by 2002:a05:6000:18ab:b0:487:af3:836 with SMTP id ffacd0b85a97d-48afe9c3655mr549133f8f.45.1790711000851;
        Tue, 29 Sep 2026 12:43:20 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a09:bac5:27ba:18fa::27d:b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48afe6caec0sm791211f8f.37.2026.09.29.12.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 12:43:20 -0700 (PDT)
Date: Tue, 29 Sep 2026 22:43:17 +0300
From: =?UTF-8?B?0JzQsNGA0YLRi9C90LXQvdC60L4g0JDRgNGC0ZHQvA==?= <amartynenko140@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>, glaubitz@physik.fu-berlin.de,
 frank.li@vivo.com
CC: linux-fsdevel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BBUG=5D_hfsplus=3A_nls=5Futf8_refcount_?=
 =?US-ASCII?Q?underflow_after_failed_mount_=286=2E18=2E53=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <debe2b6208864733c943a4d1edb93e54685897c9.camel@dubeyko.com>
References: <9AD67E49-86E9-4508-BBC0-26919C72FB6A@gmail.com> <debe2b6208864733c943a4d1edb93e54685897c9.camel@dubeyko.com>
Message-ID: <021B832C-57F7-4A31-9283-FAA5AEB8CD66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

> HFS/HFS+ code has a long list of issues=2E Another bug? OK=2E What's abou=
t
> to fix the issue? ;)

Hi Slava,

Thanks for the reply=2E It turns out this is already fixed in mainline by
commit
ebebb04baefdace1e0dc17f7779e5549063ca592 ("hfsplus: avoid double unload_nl=
s() on mount
failure"), merged for v7=2E0=2E That fix is not in the 6=2E18 stable branc=
h,
and I can still reproduce the problem on 6=2E18=2E54=2E

I tested the upstream fix on 6=2E18=2E53 (removing one line from the
upstream patch was needed to make it apply): after a failed
"mount -t hfsplus", the nls_utf8 refcnt now stays at 0, and vfat
mounts work afterwards=2E I will prepare the backport against 6=2E18=2E54
and retest it there=2E

Would you like me to send the backport to stable@vger=2Ekernel=2Eorg?

Thanks,
Artem Martynenko
