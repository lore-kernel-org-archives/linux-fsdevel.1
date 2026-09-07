Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3ED3EEAF9
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796161; cv=none; b=bsi4w8xQPTAKHpwY5LI3NQy+kb0mMeiLBMT+1UePMhxQKV8GwdsApdEVL259coKcovZrzLiolIaHsj4K6FmkQ3/7KzNheE54m5pxzwL+VfzoBHl8iO5eCSybdy34v3VloXGKTW1BU4mR0Z7NAAJvPUGttoT34LDaB0o7+ynJagc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796161; c=relaxed/simple;
	bh=dc19MyR+MdaSZ6ExG3WjVOcpiLC0WjbMFuhA4PRZYv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acYy4p77f3QHJH/57PcKqOeyS9TvHHl90Xx/RxTFWXRgybnb9s+kuEVMhIeE8u/PaMvuvA5hlYA4p2e5o2kIMwgtwtDbX16lCvZFV1ePeIRUYLp3Rv+xK7AcDokxOuUaqooKTVTiI+dFPf81BlHm9GU4ij7HzgDxXYh81hKFI3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OvHrAkzW; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OvHrAkzW"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-90e8535619bso58620636d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 08:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788796158; x=1789400958; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7bstaN9ALzEM6FurB5GuElbXVvDphHV4J4gPI6CtdWg=;
        b=OvHrAkzWOJa+Lo4uN3+Sup5/whQbgHKYebHIyDZvkzHI0XzscuE9gjgBp1GSE9ZAPc
         uI+cT0kkVmNx3dQP7q7Mp8oITquRla9YBxGlb6exC2W08ld3lw8CZu0PxRRYczJbNOse
         7TYlwiPDE9KHzuY0QNOsYce7sAFMBVjZuWDHOcWH7p9RpmlpFX4OrgN+frNRDQJSX6ft
         7YqISn57tVPgJ57EcmFBUo1ITnJcTt+MZvI46rx8P6kxvZJraBi8hEyP5+fMyiyk5Mjw
         Ld5o/XSaIDhzNOdb25sPnr93J1ljFNg+RsRr5DFv616WKGPCMygMNv9oHHPDRhIKJ2r8
         /Xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788796158; x=1789400958;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7bstaN9ALzEM6FurB5GuElbXVvDphHV4J4gPI6CtdWg=;
        b=Z5TCUKgPXBtTV2rzaQ6Kq+JVQByoShrXgHKGuA276eUPGsLUWuY19tjYDLT25kBDwn
         3oKs7pIFbcMZ8F9TVHRsGfT0Qrd38QhDSgenVsl8E6MY5IlPSKASgqknAEzmMwwTciH9
         A0g1kxsbws+qdzTv+PpBYl6FFcD/PEw0EceEZ4GvQZHn8nq7V3/ZtZ76m4lIuPcq5zUM
         qprApkXmyk5ca6Geo0ovGtGDqlqRCtIuWj0X+W3y+uw1f8xMTzmdyxU/sJGjEiuuQnY0
         P/cyDuwVexK1JwFBD0eHP5hax9evTXkcvYXo5GqN5vob+PIkKu1UjeE0P915nIoRQzys
         DQpQ==
X-Forwarded-Encrypted: i=1; AKwUvByBtVvfFX/0ackeJo+o8jXihULO2ZCtpLLbqH14ujC0ihbHFI2Cfb+wummW5GOPVldMOZVoCWWHExkJLeja@vger.kernel.org
X-Gm-Message-State: AFuF++mSObJ53lF1Ski3Z9nMwTropVLR4f5LjmPGzJMm2RF8P0fw5rek
	JFOd/6Vhr8PRm7ofTR1RUELeNFy6Atfb/yAFPGICx39QyGAQHolfMxSOjY/bnzNkvrQ=
X-Gm-Gg: AYBFou0sfOFyXIxrwuIpdHDOwWyRysUe8cuoEUxJfmPS+hMrsTyH6cnsdOTRW7WvLch
	CWojaGV1vybbzAAHBXDRh/Z5T3LQP//Xr9XT8C/Zpow+FtbiIo86XTf6Voog95wZzqZQzZsN6ek
	L9AfFS+gICOZYjSM2kQhz8NQFtYc8xB13zu/WGT+8NOCVpWjE/JjDzkD6nqJp7UO3AJWxBf4U5k
	QY+5LNp0+tVD8F3ISfLTnfGUZ/CUdqetIa3IR7ygMQ2fFQ1fv1f00w637Z0x85aqdbg/dvSB/aF
	nKua2vQmkborlUdGDh143/OrA83dwley1gH2EOqdsDL/gU6Y1RMKFi9vNJG/HQ36WjZ2fgBmx3v
	QNapkEiKb7xXEZNsiGWsk6/QF/8g5ynBUKIGwyvQ7XaPmGCeEFchk6tH6s+dBxVJXGHrRHLcz64
	wLhxdNqP8vG3uk4hlzE2Iwq6zrkhZVrsOLaOL/zJrXEnir4yx+N8eJp6XqSexyAs3YnBqztJH5F
	wo0RmFoEwubnoF70axM7sYH0bhE6YFEwF6QxLg9pu6i
X-Received: by 2002:a05:6214:2584:b0:8f0:3b98:d6af with SMTP id 6a1803df08f44-9103f06f338mr298091046d6.26.1788796158337;
        Mon, 07 Sep 2026 08:49:18 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91043b54cd6sm83510576d6.34.2026.09.07.08.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:49:17 -0700 (PDT)
Date: Mon, 7 Sep 2026 11:49:15 -0400
From: Gregory Price <gourry@gourry.net>
To: Ye Liu <ye.liu@linux.dev>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Ye Liu <liuye@kylinos.cn>, 
	Justin Suess <utilityemal77@gmail.com>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	mhocko@suse.com, peterz@infradead.org, paulmck@kernel.org, mingo@redhat.com, 
	rostedt@goodmis.org, jpoimboe@kernel.org, oleg@redhat.com, tglx@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, linmiaohe@huawei.com, nao.horiguchi@gmail.com, 
	rafael@kernel.org, ljs@kernel.org, sj@kernel.org, rientjes@google.com, 
	shakeel.butt@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev, will@kernel.org, 
	boqun@kernel.org, frederic@kernel.org, neeraj.upadhyay@kernel.org, 
	joelagnelf@nvidia.com, josh@joshtriplett.org, urezki@gmail.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, tony.luck@intel.com, reinette.chatre@intel.com, x86@kernel.org, 
	pavel@kernel.org, lance.yang@linux.dev, mhiramat@kernel.org, pmladek@suse.com, 
	longman@redhat.com, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	qiang.zhang@linux.dev, dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, mark.rutland@arm.com, 
	Dave.Martin@arm.com, james.morse@arm.com, babu.moger@amd.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rcu@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 8/8] security/landlock: convert thread iterator to
 for_each_thread_rculock
Message-ID: <ap7c7wGbJqOVZonN@gourry-fedora-PF4VCD3F>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-9-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907081334.1152889-9-ye.liu@linux.dev>

On Mon, Sep 07, 2026 at 04:13:34PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Replace guard(rcu)() + for_each_thread() with for_each_thread_rculock(),
> which scopes the RCU read lock to the loop body via scoped_guard(rcu).
> 
> No functional change.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Reviewed-by: Justin Suess <utilityemal77@gmail.com>
> Reviewed-by: Günther Noack <gnoack3000@gmail.com>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
