Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE28F145A1F
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779561146; cv=none; b=X9/cT1KeTo5sXcfbsY4cnON/49zNX3ox33lSLx5pFiDYckslOTGEr7x6AjgRLpzXYiZna3KjLqpaC1YdhUmwJqvkJQreEV0avW7i5GrBZ1Dy5V+1ZuqySZfu8AAAJCaGP/2eErCX5dIt16CBEVobems0VQBGxCerYuklV9YvDtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779561146; c=relaxed/simple;
	bh=hPajcYyIhGoYyempZ5jrgZZlm51vmw6YCtWjAb9hR8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M68U6JXnB32pSSxYCTDWbJX8enhh8f8avEa1/QD8DEmJS1THnglwv+boYT1suKSzE+ihW8ANP1rN/nkPB2I/1sspjBucuPmafFi365vNZFGvfbkpolL6KNWgvxOE1JP0OqSCWPyaX+4/QFlpF30/FdFoi2IqCJ81GNHnkxoF4CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwvzeL+w; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwvzeL+w"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-304545e6c7fso1835755eec.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 11:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779561144; x=1780165944; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Id5dyBpQ6V3HQihPc3Wj/9kDk66whwQYXcAhNcn5FWw=;
        b=YwvzeL+wG+50H6NvtNcSEbRH0yhqyRVvm5FDxXV3Uuc9mGCQvRZ7PMtiFtoTvdnzt8
         L6yepNiwrYGZzxHsbp7vc+f2pNINUnJxQBva3wH4LemL6SViLRdcDMQdPUWQbKvmjWXB
         5xpEcPwXf77gWoC9osDPKhHY6ByEJDTdE+n+qZYTYHaKw4yJnefOnpMk896TDUN29pwh
         Q4eZC56nHpKBm277rx3rWIva8sKT6nYto2snhjJzezCQIIY+pnlCfKXY4FR34sNdnUsD
         ld0/RSqWBt0UueRwERwfhnbbDjBs7QAKZykxju5NFLHVZJZrSluMJd02R8iCQr4KQkdI
         9iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779561144; x=1780165944;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Id5dyBpQ6V3HQihPc3Wj/9kDk66whwQYXcAhNcn5FWw=;
        b=K/flEgo1Nn3WQcdnCDvcEG7kj5jJa/MIKYEm/ql2bU7T26iOWM9ZGgP5TA+zZPvynC
         xvcISRerAEWDNAQsKQZU+n18QYl/6zrvVw8h2lhMheOvxE4PrFIwsVo/DIdv4folYiEA
         GU8jfqHOS6w/jJg3PcvH2QIZlicy1jvUypxJpv53kZIlygPoyITX9HfkSasWFv1tSm8k
         nwIrtJTHvjQ9h24Bv4r4290oY2J9JHJjLQEr51qQ0e+MumMrsC3Uc95HmIjVf2AXLSVE
         +59pv1CYalzc5V4JvWUMWRpCzrtiwfCjWeaEqX1jERu7+qFkzPCJSXDa1Q7bwHmK0FRl
         4d3g==
X-Forwarded-Encrypted: i=1; AFNElJ8Jpy5xsraKsRkIDMfHr5kpBi7P8cRd1nqoFWReJqSiB+Wxzcpuq9neipES0P3iykP1mBT2UiuM9/Cu605w@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7NpLERJotbXPw1qjt+GzczQ+J+Dr+fWqwiz6rljTGTghy2Wuy
	x3z0LdBrBuxpib5QbNbQJjdtj2Gzq+h/1ITVcpWxZ9KgCNc9aJHUG8pj
X-Gm-Gg: Acq92OEsLXK6x+DhPtbtIom2j37zPgjzmu8GzWfLNZ2TmKge8nuQxcqmQFArd6H7S64
	6SYxPY3JZfSC+o5zVN3n8uddXNYrAj4mk0fhJlnT2lAX2FaARiZumarrh2ye+FGs3DcEQuUvEtZ
	jpVTh0OtaWXwnEIMZl2AXDX9G13Sxqvf+cT85/K/S6qMB30ECYOHhODFrE6HrzbHn5RzyTlHLXE
	J/IxOK7xynKHMA7dFoYTqiyuR8svaMCiSUQEEs5ldhDKokRQSKAkf3+qiA7vJh9ev212WjHHcB3
	6Z80ucCg6Ln7PLCm4i1f8sT70H3dlzywLtxqOUB+H/6jkeWkuIXXI++zQ5Azv2lSYYDdMDSjVxy
	5Y3wnHIzpjo7mGkXQNoDy2xONndLhjS5fOUfQxWqNvk5MtJuCLmaa0bvv1vLHcTEfLJsuqLoEsg
	mJrs+6Gh6CBycUoevtkncUfi8=
X-Received: by 2002:a05:7300:6da7:b0:2f2:6dde:df50 with SMTP id 5a478bee46e88-30449054359mr4460387eec.17.1779561143969;
        Sat, 23 May 2026 11:32:23 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770:10ff:fc71:c346:9948])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3045225b7b6sm5660277eec.25.2026.05.23.11.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 11:32:23 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: bug-gnulib@gnu.org,  linux-kernel@vger.kernel.org,
  linux-btrfs@vger.kernel.org,  linux-fsdevel@vger.kernel.org,  Jan Kara
 <jack@suse.cz>,  Christian Brauner <brauner@kernel.org>
Subject: Re: test-fdutimensat failures after 7.0.6-200.fc44.x86_64 kernel
 update
In-Reply-To: <20260518055617.GB10368@lst.de>
References: <8733zsj5qj.fsf@gmail.com> <20260518055617.GB10368@lst.de>
Date: Sat, 23 May 2026 11:32:22 -0700
Message-ID: <87ik8enfih.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Christoph,

Christoph Hellwig <hch@lst.de> writes:

> On Fri, May 15, 2026 at 10:14:28PM -0700, Collin Funk wrote:
>> Adding some print statements in place of the comment:
>> 
>>         fprintf (stderr, "%jd\n", (intmax_t) st3.st_atime);
>>         fprintf (stderr, "%jd\n", (intmax_t) Y2K);
>>         fprintf (stderr, "----------------\n");
>
> Can you share a complete stand-alone C source file for this
> reproducer?

It would be quite difficult. The test uses a nap function that sleeps
until the system can notice a timestamp difference. It attempts to use
the smallest interval possible, which requires a bit of work [1].

Apologies for the late reply, I haven't been able to reproduce this
since my original report. I'll let you know if it occurs again and
hopefully I can create a simple reproducer.

Thanks,
Collin

[1] https://github.com/coreutils/gnulib/blob/5ab7a04761dac69403f677de4ee44c1940777b46/tests/nap.h
