Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4178E46D57D
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787248222; cv=none; b=bN/99i8M9bYGKAmd7JU5XOimZBPaAFhvJ0LXwyEnGy9QOG/SLKDIY05bQS5eNsmU1HHhC5xHfJXo6fp4tLaq974K95qgJ6E/YMcRrBtweMVbY/HNU3fTQ4J4vTx2tulPNCnfFi5Z42qnksQydC4lL/SzG/SXzpIZD7+TLhV5i7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787248222; c=relaxed/simple;
	bh=azL6pMfssI+o4ECBFo82B22ejlVXeit8z7j5FK+aJfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOVIJi6HFb9B9L8TxbyL8aFRssTbNSW1xdI9LHzl0QgfOxbsEd2GJzLtBfQ+U0hkenzAPgOAPMECUte74ngrt/0vH1tRqIvBFW9aPTaEjRtnlv8xnDejWo4Xb+CqPg7qDjHhMy5+3G9zyL31vfixX1v+fQ53921xb3+K/j2rlWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKXuBNHU; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKXuBNHU"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aec201b582so140880e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 10:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787248219; x=1787853019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9jFMUvzYyyAGffP4UVV5ruK5O8NFOvkXY87WGr65ihE=;
        b=EKXuBNHUhQabJzXgvkEafdwQxBYUfaB8PCYxTWoXW5+SJTPQcDSJiAaOiE8TwcPI2G
         9GQBntgiatGHZQtjpC72sClJe6UldGgTDYyUaZHl7VSRmZEs4pUZBzCynYn373dRpH4/
         whSIPpmNh+WmH7i1BE/lCxCa08LLJYjs4hU4MZOWn2NnTUUpglQXeuCPmsmFKQp+FjT6
         RfpJGHoXV3wrnR/v+R9/UeCcZoWDCjkm2w/d/jiqM2n5lQduGxTF+lvT6/RtVGt9YYx7
         B0qWRE/80rP1a9GvBEU1Xuk2AtFtBrT/w5dRchJsouqdFuA+cHJhP9rMygbb6PagM4hS
         3I6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787248219; x=1787853019;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9jFMUvzYyyAGffP4UVV5ruK5O8NFOvkXY87WGr65ihE=;
        b=C9qoPtc70AKfJ1Fk3ljQGMcdy4SUGdSG4oJTK3z10Bi9pEhv2Cb2RQS2AVZtMmM6dQ
         9IViP7LOhEv+SB0C0LQaMC2nUTRrgal5PqAdZndEc6nwk3rFQt53IsnIePAQxbY3qqBa
         kDYVBPu3ZNyzFOB/uiVOheH3ThlvnvrjBi0PF2ywfxzamJZhbwAPJRinDJG3ErSg3e1v
         +iW8F+SBWYMLFsGi+R0ar5oEdtMSP0H4z88VWWAK1m9963OcL+K0W1XIBpQH10mGsd1P
         ePoEV0hC3mljGhAS0W6b2o0KCaAQeHcEUSdOlxgMWg3kt65RTPN3FyR+pcZMbG4AGsrE
         8zHA==
X-Forwarded-Encrypted: i=1; AHgh+Ro9uR6E38WhpiDz6qtlsSo3nVAcClTK6gUs1Ljfpy/SrxVtCC2u1OUOKT2HSHm3S5MZT0Ju+euSmdMcAqbg@vger.kernel.org
X-Gm-Message-State: AFuF++nxSESVLyjom4EEF4yAi1tEA2VwjL3kJzf6BCPEy0nQSX/ivBbj
	g44hb7f7udT5Jtf4Dih/JoHx/6TRCrCWXmaXKI64tsw58+jETAl1lnja
X-Gm-Gg: AR+sD10hDiDuQNqEkxUY3wWfdL7aje72x4jZuk0NoBs+hfVtARUxJBF7C+i0mBEo4nG
	zJVx1IQ1LInpPX5YadNG/ybcCQmjxcblZK1YBhVgshcY3u6rjw9UO8/KQDac45APYifbfqYqNYF
	8u/6tTtZa2m/nuaBAWypehpIcmdT31piZXln4E5+JOyfeFwFcDbIQVdyHrNec8RfyvpNBsqKefJ
	A8yCey685bNlnaRgxxabpxB1/wLFSWS+rLEUe51Y5dAhCWQ6tLVc+xCxo0GlmqnVHWjvg+TYUpm
	Wfn2upFvuwTm7OIj7Fth0bh/OifLkSNviJbo/zhreGZ/li1P+O0+B5CzfXAC2DS2WCeBMVqy6Oq
	ljOMMwniEnneYjjcli1AcZ0jTP+Suka+w8bvXmQECDKihxtXw5rSOC6Ie48uPp4NGH2BwNn95Wk
	CUegnQv5o4zgzVfbqBoIN7W7IkmDsBn8xrt3ej5l3nxmrUItoyrgJAZMNCY94nsjvgSCg8yEG0W
	QJmDZ4gtqQ8FZFnXA/QCFtY61qZjmpexktWEOyqRMcfOPpxcbG+VYxH0I/ktXUdCAACtnoy40a8
	Tu/z7wqL5DgXtUG/oFWE1p/4PirYEoT5GxUScDeTp4GPgQjsSZzOYeCMgBo47oM2PtFfqCs=
X-Received: by 2002:a05:6512:304e:b0:5b0:22a6:6b13 with SMTP id 2adb3069b0e04-5b48408197amr57328e87.0.1787248219056;
        Thu, 20 Aug 2026 10:50:19 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a476-1a01-141e-2b69-987c-d72d.310.pool.telefonica.de. [2a02:3100:a476:1a01:141e:2b69:987c:d72d])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b478860c85sm1419706e87.35.2026.08.20.10.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 10:50:18 -0700 (PDT)
Date: Thu, 20 Aug 2026 19:50:16 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] selinux: preserve user SID across nested backing files
Message-ID: <aoc9pAzSVOzCaHS5@gmail.com>
References: <20260820061349.10542-1-kmehltretter@gmail.com>
 <CAOQ4uxhgMNvFxauLzm2PQif_D164+rJqmGdU5T+XDfhMJTVJnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhgMNvFxauLzm2PQif_D164+rJqmGdU5T+XDfhMJTVJnA@mail.gmail.com>

On Thu, Aug 20, 2026 at 04:32:28PM +0100, Amir Goldstein wrote:
> Sigh, this is so confusing.
> 
> The fix looks correct to me but I would use a helper selinux_user_file() akin
> to file_user_path() instead of open coding the condition above.
> 

Good idea. I initially had a helper and should have kept it.

I'll send a v2.

Thanks,
Karl
