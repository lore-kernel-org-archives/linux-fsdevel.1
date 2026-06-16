Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D8B392829
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781642897; cv=none; b=u5F+KLafLiZM7bPzxCQ7jogb2+HuunzoxrmUYvwxo/mQ/VibGybUJs45BHr2yXlJR0FUyRUx1X+dd6ehoMSrB6GZ3+lSTHZssNIe1v8ZUQA3rKnrfpqB6gEUcERfhFaDxnDVjH5deFZZ57R+WCHAwRZFzWFtdIrmZgYWc6SxWnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781642897; c=relaxed/simple;
	bh=Sw5kaEYR+kOXbMOw6h0GSGzuO0FP6TMElZAcRsybMMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDp1PpfcLWhF5LIeTq5qOl6jy6z40PRCo84yc1T8i0kZixpphsefWpTQb/MjYZ2OOdek8MmzKBti+2EpziBOrmPrFWNjmWXiga6nxJy2HG1EyB67ymtOsumcmNRJWquEizVlp6wcuZPKxCJZHOLoGb3/PDQyq4pzS+7Oc5AFiEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=sZNhXX9+; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="sZNhXX9+"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-488b3fd8d0dso588830b6e.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 13:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781642895; x=1782247695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vHjBmEtaY4MZyV1ZaXFC26z+hDeMIBdFKC6hpsQyryE=;
        b=sZNhXX9+cpbkSuQrhd/qkVQ9KMH3MK5AEqY2ezI3n3tT1VZzI+G7CTD7+R8ZgLGmaH
         hWaORWu6giR94C52lhyZfjX7iTve0DPwv6YIYH1jVlQ5hAZ0vj6cLwaFHwjFRIAetijA
         9w2sNQewsF/ifGCOHm+Wvg5+cmLpbkU8eurUQyGiJlz/R3ilAKxEyunoMSjeaZGqQnby
         oIvGV5C67Kl7t01rdI64ijkrzxsltfL88+wBVdLcjMrPO1b2V0xqg+SvnLQ7ncXp0uQ2
         uTaq7SHsZNLiYSAOOy7V6E+tzOFxF3wzNECrwH91h3AW9p0697UZNO8bcDXFsgt9DEUy
         y4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781642895; x=1782247695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHjBmEtaY4MZyV1ZaXFC26z+hDeMIBdFKC6hpsQyryE=;
        b=qFT1JNNXjboExm3n78aUfYU0whgokpV9ilPe3imIznMRIV+RpTCQr+txhgQMKgJuZd
         Yj5Ix7V++6Mkr10gZLp+P+tf+Yv4+M7+BLZP/okp8gT0vj/9WtKck6Vo3vwf+JayV80O
         DSEK/xZ5zJVLvkBFS3+5ic04UWmtdcRqvqM6CenVpXNVW2fTGpDYBp8byBAzoFtNqWz4
         BCeVJt+19dOVEeLVXOPiSt42Zr5pIJo/bU2KIyoDGNVrCp+5qacGTFm4LVnl/xPXShNM
         WirXB19Vmwi8yo7jX6uEoDvDGSNYp61mDSa1fVqMFDC8WH0AIGrAAsg+/TX6Qnw63m37
         fw7w==
X-Forwarded-Encrypted: i=1; AFNElJ8vVHEoYR2G2jsH+o2m+DSWSAaJfoBBONXlaymaU6GLq/DWJ8rJ931rHpZdyB5BrZbbOBiv1BckdgOf+wGF@vger.kernel.org
X-Gm-Message-State: AOJu0YyUijbi5AH0LkhbsdVEKJ9OB9n56it4zCIkjp1Ce7ghjGN4Tb5x
	fW7XZL/F5sCEmpBlhcl6qkdawBsuak7g4pknQKRtC5YIGoW4mluFRq1BWFJ2VT+dScWjGS/UImp
	OnwZMpy8=
X-Gm-Gg: Acq92OHUQ8O7gdpdNzXUp2c/v7RAq+quwS5OyzG1xWpc3aAHfQKWpuJ1wWeWFP8wvoo
	BxgnL90jMCrtNyBj4QUcmIb0qf5e+6cbzuALWGNUppvEDfwB8wbAlJzpSHYqV85uiTPGDSDBu4N
	ifyqwdaS0o7uhjYknFPfkcQX1QRRbyEKYRbucqQztgOt+UQKGlqy8kffh+AihN+QJzMtUFQfTZf
	U7Fs8BmF/IdSigjROKufyQhjp9xGzCR0pyxjYPU1xCi8EUsJ06VG+S/8btgd2yEo01MC73ShgIT
	0j/7oEyKvH6nt5aZ7r8xbE0FuixJPf9AIYAG7yfyFra7ua6s/pJ9tTCszxy/A5jp9cAbrOPUJtf
	QXGg1+pSiy0Fa40iva/fcdWD6cFvqgcKaT4/A4D/9M5izt3UuDIc7jsOnkbXRy7P4GE41USBaCs
	dhiO4Le7UXeLKdGeC6k7enLxUeeRyvoJnc9Gafp5+794zJLSpBta9abRxDUNf9x/jDA8TNT9zPk
	TNr3rC1WA==
X-Received: by 2002:a05:6808:f89:b0:479:dc74:3696 with SMTP id 5614622812f47-4894285f7a5mr987811b6e.7.1781642895670;
        Tue, 16 Jun 2026 13:48:15 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875dfe4a89sm5237391b6e.18.2026.06.16.13.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 13:48:14 -0700 (PDT)
Message-ID: <e94bfdb4-6932-4cae-9693-6f0d6f51aa17@kernel.dk>
Date: Tue, 16 Jun 2026 14:48:10 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] btrfs: use IOMAP_DIO_BOUNCE flag instead of
 falling back to buffered IO
To: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
References: <cover.1781597506.git.wqu@suse.com>
 <ajFFYT10i1dvAy89@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ajFFYT10i1dvAy89@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/26 6:45 AM, Christoph Hellwig wrote:
> Note: You'll need to include Jens for the block bits to get either an
> ACK or a merge through the block tree.

I can queue 1-2, then Qu can push the btrfs change in once that lands.

-- 
Jens Axboe

