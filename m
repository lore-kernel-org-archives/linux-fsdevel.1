Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA72439FCAF
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776381703; cv=none; b=a1JY2KfxrsX+23OrnBmjT6HWq6bL+PERQXt1/VaC5NYH7UPsuRVQtAqIfTTVopOItUPOFHRAPvbgk1mdBDgDo5fyp4I3dE5+ooWmKT43IBtSPxe/cKLU9rOno2qmmAwGbEh5kQqtnvZsJ9gKlhoVy/RHWHLoKNVXHrXye0VywXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776381703; c=relaxed/simple;
	bh=1zJh+gMNLh3n9Gp3wdZERWR7klivM5dIWbl3gOrvCZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5zatPnBgcg51QUeyxPkIVQ9SEloS6BS1X3U0lYPXZT+ChLyL6FjI+uQ6uR5gnQlzqDdmxdhMe8317GApZjlqryBqO6LNzsv6hiv5I+rzIor29UJ4eBgsdy0vbm9qKmKzagcuMxOwUXqDgs5EovbTthwz0Po1ohbXL37cd2+teo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4J6vtIQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4J6vtIQ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-483487335c2so622885e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 16:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776381700; x=1776986500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtSi1JUHvm8h9ZtScbheLnAanBRgPo0T9nN7jS0tLq8=;
        b=m4J6vtIQ0er4WBcUyW7Vs+GyWO0eI3k33YIr6/cLkiRai6ad7kokNdfk6bnBBbVgu7
         p03pcRtlu4Wga1uf7P1AV3TP6JETrN+3zf+UemEd1fio6FClZGj2UzHczYkQcHxdDTeI
         0s4j0Zw/AGYXKZ9g/3lNbLmfKfUeRDHMBtdOM2LENcL97WWm0tpNQwSV1ityaWu7Eqk+
         0cASWkUhGEYG+oO9GB4ZqcGIw7nWo7h9rnXljqMD1YnlFu/VCC/Rsv3DkQaFd2f66vQ+
         64ErKCHXqABWqma8RppIWHqO/jLA7SIT5TAjvYUm0HRoYkwNcSAGjl/tzthmVqZ/Six8
         LQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776381700; x=1776986500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtSi1JUHvm8h9ZtScbheLnAanBRgPo0T9nN7jS0tLq8=;
        b=ZMc3VaU8aofOZB4yzVsrMXmD1m2KtAjicxHjTZkyNwJW6y1/C1Mw7B6Lt5biLTFg+9
         XRcN2CGV5kpxkNNbuOs3YYk0ejVUKUyTAsVXITNYQmCAMaXpmT9Xy0Gdc0QRwypKr0qo
         WmNS5SiebzET8Lg8xk4EgIz2ZTuQcu7GqieMVF4dmoSrnOrl4Qz1ATSjFincmhCn9vFI
         n3C0L+00nFwygzVkMLyTFjncA669FxIUqDqRctuCr8S9kuPSbYAa0tXOFZ2alPG+GYXG
         AnIxciM8IdqLEPUftohUN9GYPLtM4coa+RuO2tnJL9t07+7B/tgQeXA4TNH37nwzU8WJ
         kGwQ==
X-Forwarded-Encrypted: i=1; AFNElJ+zTNTrgH2mGUm9fB+ymu3Y/AOsXUoUh7yNfYjdJcMVrV95+Te4SCmorORweOU1b2J6IICiXT+S8xaaTWT3@vger.kernel.org
X-Gm-Message-State: AOJu0YzewNt9diXANzzM1BLAVYkGT1E6swLYB0/Bm1l1d3IfEffXNKYK
	kxPwBF/4J3VVx859SeDFQu4DGxcRDuQCUed3KJEmi73/6oZSgY9B6jT5
X-Gm-Gg: AeBDiet3v2zStI+fJSW65JrCMTLjuGgz5WLlpDEpAgpKtD2TGL1yilF+Q1CIQS/XBRP
	P+ChoMh/9ZOY5d4ed5BrwnHT5oFpxP9KZWRTVYfRY4efc9zBZ6TdDG2svSuI/a38TcFY0+5GJ/8
	5xq0Wfvan72UG3ATatgeXYAL8aPpX4B98pFnloSQbGb7RVh0yvOh0Yedpokb+A2ZKlSaPqFkL2g
	BsZOACEe4VhT2+xx9qs+n6zEyJVERuvyIwfNrkLIbBfuFjqYlit7FNmWPHCVGD5NOEgIciCD8A/
	lc/8cSMrOLSVyg1qnJrnXDsG30PojE5uaoGpy3mGisZI8+I70vQ6LwZnNzvggWOhnak7XA8Ydw+
	XLe9/kwgE2fkTEQdWlOcOL732XsMJR+3yCgQtu+L1iUqATh84T8DbqmHPXtFZb+kwvtVkO4l0c8
	Spkr3ZJwpzkaYxHmTMX/NsO7l/SlJJpj3ov/Zr2lMoT4+QEB8Suj1xDFVZzcA7pGa0ED4JlPg8C
	FxkRWBqx1kF8ojCK+RM
X-Received: by 2002:a05:600c:34c3:b0:485:41c4:e2e4 with SMTP id 5b1f17b1804b1-488fb792dd0mr7666275e9.23.1776381700006;
        Thu, 16 Apr 2026 16:21:40 -0700 (PDT)
Received: from f (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe43021cfsm429354f8f.2.2026.04.16.16.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 16:21:39 -0700 (PDT)
Date: Fri, 17 Apr 2026 01:20:27 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>, 
	Fengnan Chang <fengnanchang@gmail.com>, brauner@kernel.org, hch@infradead.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, lidiangang@bytedance.com, 
	Fengnan Chang <changfengnan@bytedance.com>
Subject: Re: [PATCH] iomap: avoid memset iomap when iter is done
Message-ID: <hgug5jbkwk352zrwcngdofwiy2hq4nk7eq7yvzi6nru5zyebd2@fe64yziutvlk>
References: <20260416030642.26744-1-changfengnan@bytedance.com>
 <aeDjui2LGSidEHcJ@bfoster>
 <20260416152705.GC114239@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260416152705.GC114239@frogsfrogsfrogs>

On Thu, Apr 16, 2026 at 08:27:05AM -0700, Darrick J. Wong wrote:
> What kind of computer is this where there's a 5% hit to iops from a
> memset of ~150 bytes?
> 

Such a memset is not free in its own right, but here the real problem is
*how* it is done: by default gcc emits inlined 'rep stosq' which has
utterly horrid performance (same as 'rep movsq') and in this particular
case the 2 memsets in the source code result in 2 separate 'rep movsq'
invocations.

I complained about it numerous times, see this to get a taste:
https://lore.kernel.org/all/20250605164733.737543-1-mjguzik@gmail.com/

Also see
https://lore.kernel.org/all/202504181042.54ea2b8a-lkp@intel.com/

If memory serves right gcc is going to fix it, so this is largely going
to clear itself down the road.
