Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE32C35C6A3
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131231; cv=none; b=mE8I+9zh3hw2Px5nmCQLR7gWFsm7Dq0uPHNn7kcGcQvRLbfcMFY9S0GZvQBRhR0Ys7KXhOWvgueIylnmHvfy73BBNQIGMKXoGF9WHr72J7dHQbLK4SpxdHGVrQmpbY9BhHvY9AiMKg1bPEzFF2G5QW+cDRBh+BStkRZdNaZzjv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131231; c=relaxed/simple;
	bh=m/ys+Oy7wZhz/DzfYhAyQcwzJEpe5j+mlbCa2sSO8is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WmQkDaFAPktFtIbOQ859SLHexkUteNVExsP1HaNOhVWEzm5dXQ3mcY3/zkZLvuac/ExISiWDKGIuolvEROT7zrS4HXSH3nsyjjepwEs1Ozg3lCWzuD+TlhvCRAmZPSpCVRjJ6VS27szKvJgUhq01R6k2KGzpKHLuediCDJ32BaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=method-b.uk; spf=pass smtp.mailfrom=method-b.uk; dkim=pass (1024-bit key) header.d=method-b.uk header.i=@method-b.uk header.b=WYuwgVdQ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=method-b.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=method-b.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=method-b.uk header.i=@method-b.uk header.b="WYuwgVdQ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cc9f581c4so3002655e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 05:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=method-b.uk; s=google; t=1789131228; x=1789736028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dG8HOZHtiAY98dOkyP/NeJQU/ZUjP3gwdxCbOsPTbSo=;
        b=WYuwgVdQYeLubIoQBygwcn3DPAPOSqrKgiXQ4B/qwHxFdTtH/yc8r735k8iH7rMTy8
         76sMQDvNlVGVIwYBU8i34wrGI7zyciCJ4LRcsWIKcaXMKB4zS6CeDy2eYEl0DulNwh2O
         UA+IlpVMDapP+YfcXOzlTTwF9L/Mv4YtlVXvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789131228; x=1789736028;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dG8HOZHtiAY98dOkyP/NeJQU/ZUjP3gwdxCbOsPTbSo=;
        b=tXe/RDaR8TwhiINQ2cAA5CpcY1luYTD7oBrcN/al1tZEhG+pXLhAt8t3hZ9B5gqlzI
         jiwMnUhPkJOZm8yP1SLtp1ztox6VYSWExfIfXE9StTB4Rljz76Gk1M00npN5vI1qZ553
         aSVU9JFJLxQ/M4kSY6AIsaa5FRO89oaomyMezOxkHiYqj187j/WpJPU0tZdV8KHWBc0u
         nKpu2isDjlduTOQk6PysahBzHCzX1niq/PLECYtzXJbV9b5ywTDiF5YubojGUYToUmtx
         Mns/qv4RGdIUrSvbxnUb4A4r/1Y9YULXAAKBwf1CAtHHrXlqNfQtF7NXxmMlOLNqYwwT
         k0Yw==
X-Forwarded-Encrypted: i=1; AKwUvBxyb3b+VYa7IvQFeVAs2AYRBLDFDYHo641iJWgeNEkCSBCNLqz/MYy19drKnFWWHfotFiWOkLVpS+nzg7Ji@vger.kernel.org
X-Gm-Message-State: AFuF++l1wwTK2Vd6TT+c+GwiV67+XONixayzYH/ndxKfsuCHeAwBPiJD
	EYg4hHsH1vyzuNRf45bE6ZUEQiHQLdqbt+c+bOQrqB/6OlOMuRnlqNA4DkGv8KcIxcQ=
X-Gm-Gg: AYBFou2fiA//980ceYmEFDgQswIqmHbCZJeK5tUJU3fPcOAuC5icLTRbks8Hs8VoQ3p
	Ac4HjoRxDdUAv1e1drcljeBsgD6x8JYmdLTf6vAWnEO4JKcH+yhmPm0mD6G5R27qZw1JCGZG1rP
	GIwhsCY1ySJ6XZAeHkqNqCvZzJVL1ut8Ev0C1u/uVYhwDhBnzqyQPgVJyMMCfgk2VcIAypr9aKD
	rv8lSJjqb6EpfTSPj9qBNT+mgOaq4qOtqeQTdHk9lp9jcY8ye2RWyntDl1EBeUWVu0OHIJe1XXU
	/zhd+Tp3QdiArvAdy5k7gFd6Ov4xOgCMX826pNRGGPqJqnhiftM89hD4VspfaX7HDUr5p/axeR0
	ic2ZoTcCRgKkMvYHv6+Fahgeur7Wdan2RRfrN/LTqg6iuO1VMDVB7petQ/xxybYweLIf9G6gWgy
	yQwHRH6C9C4Lkosiec1soM7s/PONv0bu4crOt5w5qEpdI+lGscavd8XNOw8NPtgTKhRVsKA/wxO
	D0hkfUELGdA7C+yD2qV8coJIvmU1xTANfs1eKSxtzz3mUDh9KLoV3v4Ddwt7MjeqjLv0SUENtPy
	aUdwQb4OFR46ksQVf5aXPXjx
X-Received: by 2002:a05:600c:4ece:b0:49c:f13e:e4c with SMTP id 5b1f17b1804b1-49e610829b5mr49417265e9.9.1789131227930;
        Fri, 11 Sep 2026 05:53:47 -0700 (PDT)
Received: from [192.168.1.182] ([193.9.15.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e5765152asm105767435e9.11.2026.09.11.05.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 05:53:47 -0700 (PDT)
Message-ID: <3faab0c3-29be-44af-9569-1e12e8ed6a74@method-b.uk>
Date: Fri, 11 Sep 2026 13:53:46 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: [REGRESSION 7.1-rc4 -> 7.1-rc5] 9p: silent NUL
 corruption of file data on cache modes with CACHE_WRITEBACK
To: David Howells <dhowells@redhat.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 pc@manguebit.org, linux_oss@crudebyte.com, v9fs@lists.linux.dev,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 regressions@lists.linux.dev
References: <fbb9e395-1e07-4212-8f70-23f3cd498074@method-b.uk>
 <2226525.1789118704@warthog.procyon.org.uk>
Content-Language: en-US
From: Michael Mulqueen <mike@method-b.uk>
In-Reply-To: <2226525.1789118704@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks all for your replies.


On 11/09/2026 08:16, David Howells wrote:

> Are you actually using this with a cache?  Or just enabling the "use a
> cache" options?

This is my mistake, I hadn't set up cachefiles in my test VM. So yes, 
I'm seeing what you've seen with the reproducer. Apologies for that
misdirection! 

For posterity all the previously tested versions that were CORRUPT, except
v7.3-rc2 which I come to below, do this:

  none             read   0/20  write   0/20  [cache=0x0]
  readahead        read   0/20  write   0/20  [cache=0x1]
  mmap             read  20/20  write  20/20  [cache=0x5]
  loose            read  20/20  write  20/20  [cache=0xf]
  fscache/unbound  read  20/20  write  20/20  [cache=0x8f]
  fscache/bound    read   0/20  write  20/20  [cache=0x8f]

Where fscache/unbound is not having cachefiles properly configured and
fscache/bound is where it's actually active. It's the same reproducer 
as before, just run twice for the fscache case - the difference is 
cachefiles configuration outside the script.

On the 7.3 release candidates, I get a different result:

  none             read   0/20  write   0/20  [cache=0x0]
  readahead        read   0/20  write   0/20  [cache=0x1]
  mmap             read  20/20  write  20/20  [cache=0x5]
  loose            read  20/20  write  20/20  [cache=0xf]
  fscache/unbound  read  20/20  write  20/20  [cache=0x8f]
  fscache/bound    read  20/20  write  20/20  [cache=0x8f]

It appears that cachefiles isn't actually storing anything on 7.3. I've
used the same configuration for every version, cachefiles is active, but
seems to encounter an error when actually storing in 7.3. I haven't had 
time to investigate that. I only mention this for completeness, it's 
not material to fixing this bug, just affects how it presents.

On 11/09/2026 10:25, David Howells wrote:
> Does the attached work for you?

Yes, thanks, I get this on patched 7.2 and on patched 7.3-rc2:

  none             read   0/20  write   0/20  [cache=0x0]
  readahead        read   0/20  write   0/20  [cache=0x1]
  mmap             read   0/20  write   0/20  [cache=0x5]
  loose            read   0/20  write   0/20  [cache=0xf]
  fscache/unbound  read   0/20  write   0/20  [cache=0x8f]
  fscache/bound    read   0/20  write   0/20  [cache=0x8f]

So it looks like it's fixed. I haven't had a chance to try the patch 
on a real workflow, only the reproducer, but I will next week and report 
back.

Cheers,
Mike
