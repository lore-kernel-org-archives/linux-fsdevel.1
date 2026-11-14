Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.63.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794661921;
	b=d0VjqYWDydsUwR69bx9X/3Q91D5W/2hYSdpSd/0Rann6c3D5m2MqopUMWWVfgLc39yAf
	 MHKvuHyLCgzNEKPEOef1OuBku5jgRfzdUH2DgwFP1zQxHBs53fLOsSqxbIWwt1iLR6kvx
	 FpasGephdXXghd1/lSEwT4744iuMyRTZXbbA79rVA0ToDH7Ah/kjMTwxIUOnKaMze3EqG
	 RPXw3ul+iw/RAcECQ21cqxSvCR1uSqKuHJGLVEqEEzpzhXWtpn99ag02OY91+x/Z8TyIA
	 jHS5sIHbRPlQN0N5uW5ujC7RGcZGeHgyNC19bQ6lvh6TLAn0AfX0r94NonExARptidg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794661921;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-NC-CID;
	bh=jkIuL1Du9Rz9/iFN28RWamH9I2/+774Jzc1qYwXytK8=;
	b=EUWeaYVlCZyEQ+w3mIcIVk7lEUse0QpEzR9ZQk0Ylzgi1Gk9fVZYlK4Tyr5lVtJ5UNTK
	 2P8K4r/dL3JqgTYUrw6hY/XtEyrqZ/fNCoa0lXMbB8lfggQb+P0pYh/8H1do71dZKvkmf
	 CyhZHfX6PFpiG41KMjacZDYmUxc0jQ3kCQC7cvzmyJcm+OSgQURo60eiyPBQS+lvrRX/S
	 e4j6XgBB2dbaVQeiq2pHDwci7EN3n6TSEgrMWWPOUf5o4t+ku0VZrjMpemkS556IglVYB
	 GtKlfaUCefgVopzSTVKOdI6M5USDJjN/zZl1jgED+x6v/4I4V3n9zQaS8AoQo6JLKPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=F2CugZEz;
	arc=none smtp.remote-ip=188.68.63.102
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EF3606A32E;
	Sat, 14 Nov 2026 13:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36EF3606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=F2CugZEz
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4jRZHY43d4z6NNT;
	Sat, 14 Nov 2026 14:10:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1794661833;
	bh=15VH+AEro2mttEXcM9CvM/8eaV1naupQ60+t7WXg9kI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F2CugZEzIPVPlipR11ijhAk1soUBPyyc6ZV5rK27VMUlMaOPh3rFCBIlxo+g0hze8
	 +X28oxihHUtI/5D/SnjlM1hRRHs6H7Lo/y+BNfhD3VnuVn8A/T745M8L+Zc27F3KKI
	 Atmtmuuqc8/OOvU6OxnaiaMOA49iqxFDbthM/QRxyGXxHXcXkyTAGffV1p3YQ2Kzhz
	 KmtGKjvjtokF6caZXEEiOV5X2ukimfowUjm1PhbRGXgpy7U7y1pVOLtUINCH2QYuWs
	 qh4tE7QrQxlxF7dLAIzD9/VoICXIYrVBk7AB/EAhtwUSG3r3cUeyFkJjYslg6gLxio
	 iLL93sHAVliQw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4jRZH35YjNz50Sf;
	Sat, 14 Nov 2026 14:10:07 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4jRZH25bB9z8sbs;
	Sat, 14 Nov 2026 14:10:06 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id C4AD05F9C0;
	Sat, 14 Nov 2026 14:09:57 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <6ab4a114-57b2-40c7-99d4-55a4ac4c9a9c@leemhuis.info>
Date: Sat, 14 Nov 2026 14:09:55 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] ntfs3: existing files/dirs with ':' in their name
 became inaccessible in 7.3 (ads on by default)
To: =?UTF-8?Q?Cl=C3=A9ment_Smagghe?= <cle.smagghe@gmail.com>,
 almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev, regressions@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hungyu Lin <dennylin0707@gmail.com>
References: 
 <CAJ6F8CFSfgdZqaKMndGZtbaww32Xr_KVL3gA_2Jemgv9i9vskg@mail.gmail.com>
 <CAJ6F8CFgkgksyk6YM3NdMkQNhSFWV4depC4c-mHvpDHpnjhM-Q@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CAJ6F8CFgkgksyk6YM3NdMkQNhSFWV4depC4c-mHvpDHpnjhM-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179466179818.1208270.3574409074914180624@mxe9fb.netcup.net>
X-NC-CID: EU+0QZkIB9NezqSe64faDuFa/GTsNEnpkhwU8iFfWpWgBQYqgZY=

On 11/14/26 13:50, Clément Smagghe wrote:
>> Hi Konstantin,>>>> Since upgrading from 7.2.11 to 7.3.4, files and directories on an
>> ntfs3 volume whose name contains a colon are listed by readdir but can
>> no longer be looked up: stat/open/rename/unlink all fail with ENOENT.
>> Nothing changed on the volume or in my fstab; the only change is the
>> kernel. This is caused by commit be310476e886 ("fs/ntfs3: Add basic
>> support for alternative data streams"), merged for v7.3-rc1, which
>> enables the new 'ads' mount option by default.

Thx for the reports. This sounds a lot like a problem Hungyu Lin is
trying to fix with these patches:

[PATCH] fs/ntfs3: preserve colons in symlink targets
https://lore.kernel.org/all/20261029203457.59990-1-dennylin0707@gmail.com/

[PATCH] fs/ntfs3: preserve colons in volume labels
https://lore.kernel.org/all/20261029225856.1173-1-dennylin0707@gmail.com/

Please look into those -- and if your's is a different problem, please
report back.

Ciao, Thorsten

>> Example (the directory was created on Linux and was perfectly usable
>> with 7.2.11):
>>
>>   $ ls -1b "Game Soundtracks" | grep Reverse
>>   Reverse:\ 1999
>>   $ ls Rever*
>>   ls: cannot access 'Reverse: 1999': No such file or directory
>>   $ stat "Reverse: 1999"
>>   stat: cannot statx 'Reverse: 1999': No such file or directory
>>   $ mv "Reverse: 1999" "Reverse - 1999"
>>   mv: cannot stat 'Reverse: 1999': No such file or directory
>>
>> With 'ads' enabled, ntfs_nls_to_utf16() splits every lookup name at
>> the first ':' and treats the rest as a stream name, so "Reverse: 1999"
>> is looked up as stream " 1999" of a non-existent file "Reverse". The
>> real directory entry is never matched.
>>
>> Why I think this should be treated as a regression:
>>
>> 1. Userspace that worked on 7.2 breaks on 7.3 without any
>>    configuration change. Names with ':' are legal on NTFS (they exist
>>    on volumes written by Linux, by ntfs-3g, by macOS, by WSL, ...),
>>    and they are still returned by readdir, so the directory listing
>>    and the lookup now disagree with each other. Tools like ls, find,
>>    rsync or backup software report errors, and the files cannot even
>>    be renamed or deleted to work around it.
>>
>> 2. There is no obvious way out. The current mount line is:
>>
>>      /dev/sdb1 on /mnt/HDD_2TB_WD type ntfs3
>>      (rw,noatime,uid=1000,gid=1000,dmask=0000,fmask=0000,acl,
>>       iocharset=utf8,prealloc,ads)
>>
>>    'ads' is shown although it was never requested. Following
>>    Documentation/filesystems/ntfs3.rst ("You can use every mount option
>>    with no option"), I tried 'noads', which is rejected, because the
>>    parser only registers fsparam_flag("ads") and fsparam_bool("ads").
>>    The only way to get the old behaviour back is 'ads=0', which I only
>>    found by reading the commit message.
>>
>> 3. Silently enabling a new syntax that changes the meaning of an
>>    existing, valid file name is also a data safety concern: with a
>>    regular file "a" present, an application asking to create "a:b"
>>    now writes into a hidden stream of "a" instead of creating a new
>>    file.
>>
>> Could you please make 'ads' opt-in (default off), or at the very
>> least make lookup prefer an existing directory entry whose full name
>> contains ':' before interpreting the name as file:stream? It would
>> also help to accept 'noads' like the other options and document
>> 'ads=0' in ntfs3.rst.
>>
>> Workaround confirmed here: mounting with 'ads=0' makes the entries
>> accessible again.
>>
>> Environment:
>>   Linux version 7.3.4-arch1-1 (linux@archlinux) (gcc (GCC) 16.2.1
>>   20260810, GNU ld (GNU Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Wed,
>>   11 Nov 2026 19:02:39 +0000
>>   Arch Linux, x86_64
>>   Last good: 7.2.11 (Arch)   First bad: 7.3.4 (Arch)
>>   The Arch kernel carries no ntfs3 patches. I have not built mainline,
>>   but in v7.4-rc2 fs/ntfs3/super.c still sets opts->ads = 1 by default
>>   and has no "noads" parameter, so the behaviour is unchanged there.
>>   The kernel is tainted (OE) by out-of-tree nvidia and tuxedo laptop
>>   modules, which are unrelated to the filesystem path involved.
>>
>> fstab entry:
>>   UUID=717D6EE943D0AF06 /mnt/HDD_2TB_WD ntfs3 x-systemd.automount,uid=1000,gid=1000,fmask=000,dmask=000,noatime,exec,rw 0 0
>>
>> #regzbot introduced: be310476e886
>> #regzbot title: ntfs3: names containing ':' inaccessible since ADS support is enabled by default
>>
>> Thanks,
>> Clément Smagghe
> 

