Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1560942EEC5
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984527; cv=none; b=I500Sbl58eSw+YYC9TkybCAJL1RVyOSooxOKJg22XR3guwDi7/mJRAwWKw4JByeVMV9hjSpAWasQdAdWqEIdfMOKG7Rds+bQhSfHNT5JWvDXeMfP3rJkwZoQW1aqBbRf3s3dQd422+B91Bu8Jm8JHRnfDmr304BluOQnbaZSt84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984527; c=relaxed/simple;
	bh=99XvO1m1tXt04VQWQIo2DtDNDAXyZj4jhhF+v/jvw6E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c3tmcrLpacyoENHpe+AZvJDJU80ToC+j2xZcwTkvQCegZBo8U3ph6UdDmqC+RL4p7Fb0F4KNMGvyD+8Lm8OHh37bQDcnqPrW1Vp/VWxjXIGJF/ly1KYeSElFCovLh29GwN1dM1R40RLQPxCHz/wu5xhLQjb8zOrISBgR+MHkX/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UA6F49ob; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UA6F49ob"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-449de065cb3so2837794f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2026 05:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777984524; x=1778589324; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8bCA+WG2l36XwKBOAL1crO5Eru4kgJe59kDdNW7VfGc=;
        b=UA6F49obO66fI31qpkGb9x+U9mE9WwarSujgE88DMToeYNpYksNI3iySrGCACbKbhO
         zVevlHrPKWmeCsn3UzdELlI/XThFovU5ADneJs14c6q8IuCahxjjLmmK3Ut7xr5+ho8j
         rgLblSw3iNtCTAJSC3oFEEZrGu7ANxDda3ifaYYrSrf5Iyg7yMQDueqSpDszMwNvEr1n
         3UXhMUIqVI1pcnKCC//5AemY6mvCxU83kndXFAP7IiWKZNr92sBg+n6IgT+RRsuNLhJ/
         99NmHPZLO9jHQwssnWEedHU/jUxW6kyCEco79TiF1tk6W0oQvh5AnO397JWFvZ3Emw+2
         YRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777984524; x=1778589324;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8bCA+WG2l36XwKBOAL1crO5Eru4kgJe59kDdNW7VfGc=;
        b=OR9n7macC2edg5A8DAcapO2g653b7S+CA6ZzWt+D42Sgzu4asyNV6SxXRP6uFiyARV
         t3bR6ct3vXSvqslIxZRh8Z46eVElO+s2aawgrscg2LF2R5Y6kteYk7enA9pglbu+tMBC
         4hezxxtKtd2hh5V/uHeYKXfLQzmAvjwiRKhLUcgzZSZo+bdfRLnTNC+fwOSqrPeZV/H2
         pVOCTHQr+mrvHvFm+VEKt6+2xBmsDR9I+DGPyxms1u6RWQdptEABbne4JH3s1uE/wn1d
         aowKusyBYbNWqHItS5lTvXUu0fkIVD+WYoNmphXZqMyfItRzI/qcB8g5MwDPqI665vHY
         LGrQ==
X-Gm-Message-State: AOJu0YwzAMmOfXBflO8f7473TzM2ya7gHCr2dnyNwg7U5EyO4ZSCLRh0
	azX3gWXsvxxkM6mikuFqbHcrO52yysn2npjddGvqNVE4CzprXbXNF0w=
X-Gm-Gg: AeBDieupOSpoZTcN3Baih8NZLpF7AbOPvjYesgYnImkFdclEyZzjRPMKsSjSZ7d9BQe
	EBebKJI3JMurjkmfXjZjNeEIQ9UTm/pNDINKiluaOMxMCvR1hFZtY00e5IOj7Ef/uOtBmXvAPxN
	YNJFt5rhA5I/IessfG9kIh0TDajufnktFnU5H36FiIDApYM/75uEwS8ektR8LsIFnoyFc1w7igy
	p7szskA8q5QcCiZ5ilP9hUkeBeFNyR5M0OTZafZrcf+VJmQqhDAcJnMWbetFMU0mVFyajyg2nxu
	N9XTksz6zlJebzf44wf6E4P2wIVQOD7Eg11FQaaxGuvYq6iX4gNw7irGQ0KOK5lMNllYMWuA+tB
	l2Xg6ECASg2OPL/cs69MbOgSqSi8+cOloWkFyIBjw+a6TbC457NZa72ku+oMkHw3QBDi+gV+yFH
	xH2ReWkCSOl9eJrTRa4N1KIJcmvISl7/C5nBXSO1NGfBjxf54FPbaP9ngPbzuoE/4qIw0swWJa2
	BA=
X-Received: by 2002:a05:6000:40c7:b0:449:af52:614d with SMTP id ffacd0b85a97d-44bb38bc2e9mr22959344f8f.11.1777984522723;
        Tue, 05 May 2026 05:35:22 -0700 (PDT)
Received: from p183 (dynamic-vpdn-brest-46-53-134-29.brest.telecom.by. [46.53.134.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a48b23sm4556142f8f.14.2026.05.05.05.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:35:22 -0700 (PDT)
Date: Tue, 5 May 2026 15:37:43 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Why does GNU sed abuse /proc/filesystems? Re: [PATCH v3 0/3]
 revamp fs/filesystems.c
Message-ID: <9c9da11e-45ed-4105-8242-391c5a9e52ea@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Cedric Blancher wrote:
> Why is GNU sed touching /proc/filesystems in the first place? This is
> not really a stable API

/proc/filesystems is very much stable API.

Arguably, some fake filesystems could be hidden to make output smaller
if it helps: bdev, sockfs, bpf(?), mqueue, possibly something else.

	/proc/alexey
