Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCC633ADAE
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 03:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787889059; cv=none; b=kNjbIeaQ79TCx7N8i4m8V3mBdb9Ce3bgKevrwQn0kMVj4tHZuePsJXWbl8tFvYGiJlxKOdVmhw1c16DM2CPLUSdWbUZ+jKuHl/dYaT46kGxdoSnod5VFzkD3xchCK9jHAXrZyT2c6ZHuzdOzDz0DbKCoIYH2OYZKbttHQSfb6RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787889059; c=relaxed/simple;
	bh=kq43sLBz2ZHXLrl07cvrQHErCwpMzQX0LD1VRAlDuTU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=RPq2YHGKg6zGyRUb7cMcTfyp5d4tVLxKKyQabjjn1n9Ans8JWTYXhlqLGMXOx2WQmMa7w2tjFUWR2AQNxCriiW6CYwqUZ9Rm5dt36Qrk2mxCc6LQskkwf7ojf16exVw5LgUm/puJlvIcoJVj0ZMoH0h/IBR51nl2F6+1Z+O2O1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7U4HWhw; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7U4HWhw"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-396b3d0df94so698883a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 20:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787889054; x=1788493854; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3KcPIBnQ86fi9vMxouOV7SSnCq2u1kcpTpfhzejq3Hs=;
        b=R7U4HWhwLrwKMC+FupEIzsfEhLvkgpLRjCuG3fdRGIljVMKbcUWbOmNIafc+8KVkyX
         qzTfcd3PB3t3/jaQD8N50cEdW4hbc410bFTwUxI7LwATn8I+Lpqa/mFKJyComo2SusIV
         xJwGDdklVmGtT46XLy5JByHJf983m3WagzUdyOFq0XRQZqjc0zx4C+jsFzpMH8TE4x3U
         Sno4HDcLKkj3+2hW/v0XuOwqDjeTHBou3395tlXX2tr2KKxqXZ5cvFzfFP5485jbhwJz
         zsvaC0BLJA/2+GdpRn71zBgS2LJuhOEGC6szDvEEJ4bDnO5p9b8cX1QskMBPH/onhBU1
         jrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787889054; x=1788493854;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3KcPIBnQ86fi9vMxouOV7SSnCq2u1kcpTpfhzejq3Hs=;
        b=lrO8WcQfg5FYgALYDw2b11Dph2M9SQA2c2DVZEP8upfUCUr8k11mhnXAOlzqL/d8OL
         WIcdFn2TRN9nmyAin/EmueDMroJQZPXrDd39JdZCzXS681bF9Tx1+IR+FZusnEYbWlj3
         oUvdKvkk8oZpPcUadT2ky5lSyJTFbO5+PEg0nFkt8T1YrB51SrDqxhd/oZKVdOIgGWaM
         07eACA6yCMxFzbrq3GgmepOZeQsNT9XHZNf8kuBUJpHoJoFt8KFkQZUHWOrsHfc7eTXW
         6QyASqmuI6gKCgq7ucZBlUeNz5fEeFAvlSjDsy2VHQard238NJaxvaXjE4oOoPL0X9yx
         ktrg==
X-Gm-Message-State: AFuF++nTDqZRBK5O6vAPNZbiznPKz0MfvMXohgH02qczzQCU0ljSsGn5
	/mBxzaWamar+O5YFeaBtGe//Inw90e52nmT6PEvfZOuKWGKcRgjPf7K6
X-Gm-Gg: AR+sD13RST0VKTczfw4hoG6vTgH3xACGI1/FfNGo9LLgNINMDrqsOV1fwj+gKm+FVon
	ERkKCwVEUBlSycHOXN81LFn239geR1h8EVy6rBsEHM0wd74m8XEQ3MmSfRxjryW0vW6H/ipndzI
	gWKdkOR5FMtGfXwpNyA16i0IppnQW30djFB0NgXmzUiq26chACaSwbu0GqN7NhJ5E1g7D+pQzqm
	n6AcRCDdNP8MLUjzuvAf5Aqx0jHdlXwaHX61IMsJRh7Q5unnOw7j+c02ohGbTo1W3bC55pUAciH
	zUJ3HuzcCpDD/S6ieeWZT9S7MoDBJkmUjaTnF4YROOcYx4IKx2O2SWn8NMDCVUjKWXD8248DLWW
	VVbVAdmymfIRRu4ody9yOHESDJhJYhO6hGZUoh0F+LoXtw0P5tYfqMe45x72GCZd77LTEYuCA2T
	hS67apHaxHiY3aouS0w8TDvVKUbqjQxf4b/uR5/1wHy3xf1zBcnT/MUbhSZBaO5M5zlQ==
X-Received: by 2002:a17:90b:2d82:b0:393:194d:5366 with SMTP id 98e67ed59e1d1-396d0f6f8bfmr8174751a91.10.1787889054288;
        Thu, 27 Aug 2026 20:50:54 -0700 (PDT)
Received: from [127.0.0.2] ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0e0e67dsm1659184c88.15.2026.08.27.20.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 20:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] binfmt_misc: only let punctuation delimit a
 register string
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, Farid Zakaria <farid.m.zakaria@gmail.com>
In-Reply-To: <20260826-work-binfmt_misc-delim-v1-1-43618adf8599@kernel.org>
References: <20260826-work-binfmt_misc-delim-v1-0-43618adf8599@kernel.org>
 <20260826-work-binfmt_misc-delim-v1-1-43618adf8599@kernel.org>
Date: Thu, 27 Aug 2026 20:50:28 -0700
Message-Id: <178788902860.3236768.6730484936359324341.b4-review@b4>
X-Mailer: b4 0.15.2

On Wed, 26 Aug 2026 17:55:46 +0200, Christian Brauner <brauner@kernel.org> wrote:
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index ddfd3aa57ac8..809c91d21b39 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -100,6 +100,13 @@ static const struct binfmt_misc_flag *misc_flag_by_char(const char c)
>  	return NULL;
>  }
>  
> +static bool misc_valid_delim(const char c)
> +{
> +	if (!isascii(c) || !ispunct(c))
> +		return false;
> +	return c != '\\';
> +}
> +

Is there a ready you did not make it a single && ?
Feels a bit weird to check the negative;

i.e. return isascii(c) && ispunct(c) && c != '\\';
(DeMorgan's law)

Reviewed-by: Farid Zakaria <farid.m.zakaria@gmail.com>

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
