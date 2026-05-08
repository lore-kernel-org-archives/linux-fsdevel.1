Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B5434A79D
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228760; cv=pass; b=fGplxL+D9YOouwC8+ZxWvHVFHk8BcI1FPyuXcTG9qyhW79jM3YxmtZcMYS9Jl9Mog9sKTWQdWyGvLaaMFDVoQQPhyjRbYEY9wMEmG1woGRRoUqeERBIw7rnakvV2HFZsNqTSglrX3ACxCfuPY4D8T9WZceGEiFZd7wfq6tn23GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228760; c=relaxed/simple;
	bh=d1lei6XoXsI9G3PPKb+zRNb7VZ9FFZM1tcLcjnNn1r8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5lCFrzu5TcS5nHJ2q6Q3bB9LhAofn2HwYwVbA71s87tKXqQr28CDoKKEQ9EiYK8usf9xQWoLhe4KQ5bWYI5VBK8PB83tJ7et/9gF47PMWMiL8P9QbkJoZYP4buo5h3FjWaOwp6H/U4JDkBm521LUVXb6bscinzF2dBq+RyV1Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c7GOE+H5; arc=pass smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c7GOE+H5"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56a86f0a23bso1660732e0c.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 01:25:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778228758; cv=none;
        d=google.com; s=arc-20240605;
        b=UdDgdR9Wy50ze5Zh15woQ6rW3Kh7Nqt7DFOxYQx3QAfcSYGi9jTVlhPOrL96cJjpm4
         rCQj/APfEGV/Yj8Fvklbw6JDXqBOJansQei6N8D12T+NJLgx3H/RaoZxQURiJaidNjXn
         /8U8ffxEt8gx4nvO7uNC2bfAM52XSOk0xnDbnWJ7uf8fHHpl74Y1Xl//MjYKKaVNEAPV
         y1DvrDng0pqKddzSf3nrLg0VCAkWONEgX9wNSthkFJKAp8l0x6yt51YEtqNMKqheG6Pc
         uplxSfkIBEkEsGY8oqC02AgRaMrdQaR+aMzdKWHmGAE0qWRBqTaIvJ+umuvsNHE09iV4
         8jKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GJCG5dLpfAuAyp7lDNzWQXnNWApOwum3CIYmhqWBvgQ=;
        fh=2a3IMZEBti1TEXtWONH3brhMSOkg8Py7L94y9ZRGJYM=;
        b=MuhhIwiWTuABsZ4hccbBhBa4GfXJFqmUmocpaaZjMSVVwyY1Q305/ntGSkarf4TuOa
         XA98bE8UcuK65dmjTO0Tw0Y3NtK99+OirPTcjlbCfWaPSSE3S49ccJYmqPbljrhYD+1/
         Aw6ZLAZrOAjcuGg++nyOGR6r38tUT+PmJymbVXK3rmEp4hfs1/8MNxeBDmnrwqXEx/sB
         YqTLkozGwm2XvpJ1cuOiL8YKEeQgUZEWifrvokyOZayZsvuwg4JKTqxNOqRYIjeb4eJq
         DKccitxyjn9OS3yEvbvmoy8oE/06mW+Z3REe//wlc5m6n3YRBDMh90KlEKCqTvt3ghwD
         t6Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778228758; x=1778833558; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GJCG5dLpfAuAyp7lDNzWQXnNWApOwum3CIYmhqWBvgQ=;
        b=c7GOE+H51sPzEmTZs2fTE/GLdfUkZTAGUaXV1vnsOTJbgSYQo14k6Tue/RW3J1Pkj5
         YWlamGGiETU/2gsgyhHFvXhcGRx9q/8yVRbHXYJzv4/FReb0lAeupRQochRB8l0fwrH3
         ASJkflw/GcLr3zgTB6lQqBE3kM4pnIMBGxoeKr7JXrVlxbZAz29h8zhxNsW+ORq0z7Bs
         KTmuSjdxNCpcfIQK9XDXPgXhNn4RPJmuu0ThgyX/ACH00vC1/1+Qsy4K9d5sqwCTZyzs
         i3N2FXy6waA8FzNUyUAqoW24PKzYK8inDbh/vSaGRsLjWzgbauQm0aZ4Nmr1GZOyzHvQ
         y2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778228758; x=1778833558;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJCG5dLpfAuAyp7lDNzWQXnNWApOwum3CIYmhqWBvgQ=;
        b=Q1VVn5A5Y9y6+mWNuyq7ZcB7ar9T1ATuAbMtZxf/gYhYJ3pcRNyHTa3ptvrkAIYK4C
         tigwk276SK6SrgWs3EmoE5u/FktiOy00hOch2JOqNLO1YVvka5P/Y2IhVjx7VfnWB8Pp
         UCR1+1NBx5RnlJw1W/ApTRBddNuucni8LbWBxcsdwHluXqfgmWbfhVd27+VJxJzNyEwb
         RKk1jLyvn1npA+LotMhFxdWqBZM4kpro6I/P/N7p92cU6kCe1urVDukzaYZzJlLds/JM
         92ub8pLQV5xOGyPI8WcGm0P1oZKJm/k+qbQh2+IBWnJJ17m6hZ0ZIg+FhUaObQ0yJ+qp
         zdhQ==
X-Forwarded-Encrypted: i=1; AFNElJ/bYJx2mfWGZKB2SQ5hH2ME/+RCPd6QsBilcdy9OQ0s7/mlVyOsZu86XSIZd4P8UCnUn1mRXMzy0ivSEpcQ@vger.kernel.org
X-Gm-Message-State: AOJu0YynDb2WnHwWKqgorm1z8AP84Av1teHwJ0UzKjhgsSrgBGtYUf3x
	R7Xerbn3zI6as4sFbbCqI7PRMCKzWgziwS3rhrn5CHNAm1OJifSrCj8cV7WnyDd2f1BS0BE+f30
	hv3zmvgmbJ7eKoJr7rgcaYKPOXCy3xoVt4tnbr54E
X-Gm-Gg: Acq92OHKQ48rSqIe2VfOvsjXqtTUjA39rIJr1RuowUNxmiz0SzqoaNcDlm3F0OxXOtI
	mHGMbW4NrvkNA2jyywfzTTrf65lRee1XT7EsV4/u/RLKVOo5luNkLUhslxG9X9olc6QP34kihwS
	y5btknn7mZXPQf8wyV3+3MYXMgIquqQay2au+DcYSUf4gLme0GIFzMtrm9zYGf1iUTHWx8bG6tn
	5kmBFAmNpIPa8hlR2/zWJBTr18WF1dZyw9lOhq1TlLkXGSmaWYjUyua+/z7FaPOtZJvcoifIp1F
	mio4HoKpmE0xMY4vsd8v0jdOZN8FGNm+VhK5jOQ6VXr3uqCEzv7AK4GCCh/IyRUvYTQIZtXebWS
	8EIOMPn3QC2rJluhECN77a2DZT9W8rKrK
X-Received: by 2002:a05:6122:4d09:b0:56f:7c7e:f33a with SMTP id
 71dfb90a1353d-57559269776mr7378297e0c.0.1778228757559; Fri, 08 May 2026
 01:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505155615.2719500-1-hsiangkao@linux.alibaba.com> <af2c4X1YCB7NEb8p@infradead.org>
In-Reply-To: <af2c4X1YCB7NEb8p@infradead.org>
From: Tatsuyuki Ishi <ishitatsuyuki@google.com>
Date: Fri, 8 May 2026 17:25:45 +0900
X-Gm-Features: AVHnY4L1KCiaXjNXymmI-IMvyHXcvVitm-UHJb37xa7QDYJ64qIHU29FH7jlFoI
Message-ID: <CABqzrSNDWO90LY6m4AhipDDq5szygKuZ2x_mFEVir_reyaB+pg@mail.gmail.com>
Subject: Re: [PATCH] erofs: use the opener's credential when verifing metadata accesses
To: Christoph Hellwig <hch@infradead.org>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org, 
	Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	oliver.yang@linux.alibaba.com, Carlos Llamas <cmllamas@google.com>, 
	Sandeep Dhavale <dhavale@google.com>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>  - using the opener credentials when accessing the backing file seems
>    wrong.  The entity accessing it is the file system, so it should
>    have system or mounter credentials, not that of someone causing
>    metadata / fs data access.  And this applies to all access by
>    a file system backed by a backing file.

I think there's probably some confusion of terminology here. buf->file
is opened with the mounter's credentials, so we are impersonating the
mounter here. Perhaps the commit message could describe that more
clearly. Same for the previous patches mentioned.

[resend: previous mail was rejected due to HTML]
