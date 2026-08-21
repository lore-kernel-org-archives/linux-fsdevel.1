Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BE739282C
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305647; cv=none; b=Cwm/Zuej/nCCJajHNkaeeiqyT3kWUD+JoNvUtz1qqQH41LVuaG5JwsT1atxWOYFnRM5gM6J5E6NF10HYxsXGiJEnTo9laZJ8aRrPxiZC5PFL0GFUxs8G2XhI9RmQD4b6t0d/oiO/+lyshbf0q1+SlO2WlIyx9ZOV92AxHoloh30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305647; c=relaxed/simple;
	bh=aR7WYlaxKUmBaZOojtRZDxqESOtVxTNnI9A7EVNIiWE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AsQPyxiDuLWGn5FkJVIzvEyzDlIo8uKB7b6XhBVzHnO3JYvsO9Y0B79ll4+bF6BmW9+ENDGfm96faw/mCsqcR0nS+zUnToBuyR6pniBNeXkLARE64MumM/TV+TdLs2o95HhPLV64P/MHvKsZHOxGG5nh4u7PXrnsykP4JLvK4Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=C1mnNMQu; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="C1mnNMQu"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c214e625259so111010366b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 02:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1787305637; x=1787910437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aR7WYlaxKUmBaZOojtRZDxqESOtVxTNnI9A7EVNIiWE=;
        b=C1mnNMQu+vSwtzbHPfvX9slE3ngp4uaAruJWJH4WhTmLYJrRN6ANzEVRZFYQQ/nJ3j
         jdGG/6yonxIksgXCQlEDDZAbkrsgvv+lNDepni+mhIu/WwfHxBjoxYfO3749paJGh4kC
         AKrIy3itkLYSagsiM/FVofvSQe9pYPt8e0Jh3sjzl+Z4/s8JXKQMXu7Is0UtJtMj8bXD
         BE+7syTivOizf8/m7RdHmX4giK/JSAcb2MmUAK+0dzZ1OPRl07ZO2KNm5KI6+2UdCsQ+
         fu8dN38+BV7ViE/PQnbSqY28YBbMkDelPMJ8Aup4wLsRGMHjOft/Vx1XdhQxABdyvqlN
         VZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787305637; x=1787910437;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aR7WYlaxKUmBaZOojtRZDxqESOtVxTNnI9A7EVNIiWE=;
        b=tERX5CUEbssITJ0FkyV2mvfsp3Dp/oEnv726qA4IdzmIyv8lmucaWJo2W1h1qQUArU
         fvIP9t5fRo7yAqOZPLVqAYE/eEvcF1dJeuC7GsOffGn692uhXO8QMJL/gkyFw9072aO4
         1PTnWjAEnt+SdZu6++AaD+5CSyXgLeglGZndjXgEz0ppmSWglc8UDRhUL32EXXR8tYmC
         5v6S4hUTI10YfIjwZorbgTyOQopY7btdh0L5MCvOTyQIK52lO+JqThkzhIeNt3mr2tci
         LddHKZck9wA96MaRjo62aiIXBITfBGmepYHMub+1AU8/Q4ljIKnXHx3pGKc1e1EHR0Vh
         0IYQ==
X-Forwarded-Encrypted: i=1; AHgh+RqC0IPOz4aMWyzk/KqjtYy8hX7MLwv1q+xyLix6uESxF1FpAv7TflJQxIEhWeRfI6Ppkp+LUe5176juNrha@vger.kernel.org
X-Gm-Message-State: AFuF++kPiBRR6okPEgIyq8OZAqbOHniyARpxoY/jF9gtdI7k4F0vCLdy
	6tH5fe4PejhMez5pLbJ12VpCK8PXgNGxkzMvqthh6TJnH4Yz2QZBusaCWroa6zhDgcE=
X-Gm-Gg: AR+sD109dDgia+xkkQe7TrM/8fP7dGvAZcv/HVTS4stAnJi1T73UUAQ+5CJF+kih3Ji
	q1izoIRaXIU7y8KoF5YSGUdQmympaYuRUuX+NgPOx1c8aL4SttybPGBPs9dRq9URrKrJU0K+Zkn
	3z9sYxItJKtrwOAgcEHwyuXK4bxF1MMFdGU1jV+46O/qBVVmpnWEiFx0FiRJkusZmuCcVUE5Qse
	tAlmXPjzy0XiZW6ZZnZ2w8Q8OwWX7xneDsFCiqYKkn/VwjCXVpFhitnuqHSIeMK7nW7T0vNyPyi
	i7dRQQHnhptTW+1DcXmbc8iKxoph/ll6CqUPneLecNNBugnhRBaxZdYp8OkFGa+HtI/CUhcUNsn
	epkXDhGqvI5ym92FT56ZFipRaPl33NnA30NEekDzx7+t1qggyUkm6FCZvDMOzpOFCFCc+FCy886
	vAON+jnhTkvoekVizl5u4iccpdYTxEwtRQM+VMzSFBnkFtQWvlwsV7DJF2yYK6drl8C/wg6ta/v
	RVLB5QUAIIgajPFhY/LFFbOQPlxZNaJSkc=
X-Received: by 2002:a17:907:e90:b0:c20:33db:41d3 with SMTP id a640c23a62f3a-c246a5f45aamr534704466b.11.1787305637389;
        Fri, 21 Aug 2026 02:47:17 -0700 (PDT)
Received: from grappa.linbit (62-99-137-214.static.upcbusiness.at. [62.99.137.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2459223af1sm395865166b.58.2026.08.21.02.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:47:16 -0700 (PDT)
Date: Fri, 21 Aug 2026 11:47:15 +0200
From: Lars Ellenberg <lars.ellenberg@linbit.com>
To: Moritz Tanner <moritz.tanner@linbit.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: don't return -EINVAL for successful nested thaw
Message-ID: <aogeo1t6G8VBu2oF@grappa.linbit>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821085451.65206-1-moritz.tanner@linbit.com>

On Fri, Aug 21, 2026 at 10:54:51AM +0200, Moritz Tanner wrote:
> This breaks bdev-initiated freezing. When a filesystem is frozen with
> FIFREEZE and additionally frozen via bdev_freeze() -- which nests by
> design, see fs_bdev_freeze() -- the subsequent bdev_thaw() receives
> -EINVAL from the holder op although its freeze reference was dropped,
> and therefore keeps bd_fsfreeze_count elevated.

The other thaw order is the same defect seen from userspace: while the
bdev freeze is still held, fsfreeze -u returns EINVAL although it did
drop its reference, and the filesystem stays frozen until the block
layer holder thaws it.

In-kernel holders get the spurious error as well, whenever a userspace
freeze is held at the same time: xfs_scrub's xchk_fsthaw() carries the
comment "This should always succeed, we have a kernel freeze", and
f2fs_ioc_gc_range() hands the error to userspace.

Tested-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Reviewed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
