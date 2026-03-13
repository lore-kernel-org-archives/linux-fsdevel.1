Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74E13C0610
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773418009; cv=none; b=DkBf4ShKRWLU2dLUevFkXvRIMqnOKhZINzIsT3AciWCXlPFgNNUEW7eV0HAC8D1Li6xbV1EeqEJ2gKJyE2J+bUiRQEM/X/8qprHFmkZtPRoc+Fo61hFMFSVXRF09sZxeWhPfFkw89BOFi6OeEq3daD+X4tyEgNyLZ1Z/W80V29M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773418009; c=relaxed/simple;
	bh=mrgB6OYq5fl6la156FZGEjM8+cGmsWQazLL+9mA/3YM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uctj/ffIbGCtdD4z8xY1KIVz7KZUl6HD/biR9tMsz5z3/X41Ojw5sk7KzSY2IqlXKexb0yA5P4uA+kJoMXoblvgRnavbD6ibFg6IG/4LeQNhYYKLT6xTak+J9C0/P1swtnv1wvnUCfRtg0IrrxF7PavUkqNneFRSkQunSiebod0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=16zJbp0A; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="16zJbp0A"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d73ccee442so2496771a34.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 09:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773418007; x=1774022807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wIGUjW2HEf5IAtuw8pLHFD1v6D6psz7Cx6Shlu3igSk=;
        b=16zJbp0ACT8RrIF2FoehxWQzpwxTRXPKVzfMIAgUGQ12zsW/H9XIfhff7ecLpkYKp4
         Dg6aGzY4WuPb/bpEs8PE7Orb/wbWsbqUPOYynPqx002QSDAfz7ff0hhQGLgLrIa4+Xys
         ZYxXkuN038Eh0M/4Okpg3uyTXtK5Jqvsars9HPGTYSxVqjAbwHhNlPMyJhml4E00q/Dd
         HzEDdpK82ZGzwvZXFgpNRWrcpwNmm+LHHTwxHljz+PyQKE/bbvbwZgEW/ZCD5RMtQfNU
         DR8sMYKEyjSYS9pSreA+/bhyAriD1SomiKBbp8vVLJ5aARG26ob3Eydq3LCYIK9SILdp
         gl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773418007; x=1774022807;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wIGUjW2HEf5IAtuw8pLHFD1v6D6psz7Cx6Shlu3igSk=;
        b=cLgRMumhXNaPq6tiQIAz1wwLqztJLP4PDoTfdXCK4vkv46Bwe1ZfGWkHd+wtU4GHJa
         nZ103rgNNPmwnRNz1SPaTo0sGf2frrepL9J1zof0rDc0wB27qEsgb9ZZCpJ1S+4X8LL3
         mYpICcarDvu1aRMae/eu4Y4ALymL37IE45wqtjPpx3MBM1ud5rPsETzyZ7wpf+u0iMwp
         4cZvzxCxxr4lsswO6Hf/aOWjk56B+o9sFN+pp9FgdbcH6wA14b0JXE3E3hjZHikyvahM
         Hxc/7DeDjsrHJE7WY0Q/dxXfRBK0LY9tU5FkxFyx+C9iphSpOrz9BOwSpLL9lXk2VzKT
         CCOw==
X-Forwarded-Encrypted: i=1; AJvYcCVa78A1H27nb8FGdJVKjvyJqE0buc+vNyB/80CAFD2zjMMVKjaQFktxROPIriKKTy1oHE5Ods75WMp4MavM@vger.kernel.org
X-Gm-Message-State: AOJu0YwKlxISQht6bO/eg6cilgPxH8hgwAVVO+X6U4tYJ6+y5c29uYUA
	o+UwEDUX/O1482zEMFqRNG0bS55LxzJ8Y28cZ9uaHXE9LkAV5I5v24/TMJZnos30fo4=
X-Gm-Gg: ATEYQzxHxw1Ulxgf7ezbr9pLhoiOSHgW/CtwBDi/2z3B1yFxjFE+cvCEx63HwGuV+c2
	YRJYwGrSgxmT94EXEJUqhLlMf5QVMiUMqMyhFYp/hRJx/mxG9Euq+Z/YccOZ8NwIZ7kuWIVVjcf
	QgTa7IRQQSPsUEe5T0qbvN/tCwyv79Vflk35HxBzvCPtH+L6gcRqT33LanA8kR7R122hHZ7hq3b
	04XvluORZQGNbsKu9jAgWKx2PYuqmwiDonTaJzTzWtdHQzHp2cTcx6ZZkWM3YxubhL2cQPaDy8S
	uJUGAeYV9UWc9yIR3Gb9f/3Im/9VOtYgZc17CGtDcfas4WLWj0/kBBYE8mxrVqatEw1ay0B3JUB
	EP/dc1yUNfA3RRPhejYQj8N4gX2aVnYh5QN7td1dJiawH0yhT9EWVqngDrMUjKnHXnT/C7kgfif
	6CtVZ02qCxV4nDvd5EQmj6TwUcxxPZwMZT0VzxMddIiROmGLC0j9GSQKL3uP8kU14BNTRNe5V/E
	/fpmxZotw==
X-Received: by 2002:a4a:d312:0:b0:67b:dd84:2798 with SMTP id 006d021491bc7-67bdd842e6cmr1168312eaf.57.1773418006742;
        Fri, 13 Mar 2026 09:06:46 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bc9307b4esm4858249eaf.11.2026.03.13.09.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 09:06:45 -0700 (PDT)
Message-ID: <9d8205fe-c788-429a-985b-8472217dbe32@kernel.dk>
Date: Fri, 13 Mar 2026 10:06:44 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add Josh Law as reviewer for library code
To: Josh Law <hlcj1234567@gmail.com>
Cc: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Vlastimil Babka <vbabka@suse.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Josh Law <objecting@objecting.org>, mm-commits@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, "David Hildenbrand (Arm)"
 <david@kernel.org>
References: <20260307221931.2848601-1-objecting@objecting.org>
 <3cd25de5-3737-49f4-aa8b-eaaee471af50@lucifer.local>
 <ee644e1b-5759-477f-8aec-35c91a5a938e@suse.com>
 <20260307222154.2848660-1-objecting@objecting.org>
 <667b75ad-bce9-4997-8ebf-8077952c2797@gmail.com>
 <20260313-anvisiert-gemeckert-352414e3d58d@brauner>
 <20260313-halskette-annahme-94e782eb4ae4@brauner>
 <01a6bbcc-1442-48c7-be5b-14f07fe655c9@lucifer.local>
 <28175752-2775-476d-9485-499335a99aea@gmail.com>
 <e2278198-22a4-402d-9179-c7cbbb186d5a@kernel.dk>
 <8bc3ea9f-4e56-4e41-8cf6-97e3b5a45b31@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <8bc3ea9f-4e56-4e41-8cf6-97e3b5a45b31@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/26 10:00 AM, Josh Law wrote:
> Thank you guys for the context and the history. I understand now why
> my request was premature and how it looks from a security and
> procedural standpoint. I appreciate you taking the time to explain the
> 'Jia Tan' caution, it makes total sense why the bar is so high.
> 
> I'm going to take the 'no rush' advice to heart. I'll focus on the
> technical work, learn the etiquette, and prove myself through quality
> contributions over time. Thank you for not being super mad

That is the way! Just keep at it, it's a long road.

-- 
Jens Axboe
