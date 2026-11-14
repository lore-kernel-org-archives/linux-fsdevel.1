Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794671011;
	b=twDk7C5HQwkp4yObmc1+PbIEXy3QJuPIRsbZELHI8j31ps/NGzPT+sb/addVyJvdYdWt
	 JYfNoz8dE2sfoXfc1+dlONa/BEguwchCn/Up/xnj3B8UZnj1Crhhl3hcjfc4DbI+eg6Dy
	 4ki6bvuYmxuVG5MysBEq08rnyhtqV978//Fat2jAnzseSXxhuaQehd1PN4/haP+88sBlU
	 UB5qteALt5dLQYjT8c7URzfw8LfkU6ulzsiTSAWyuUzoEJHt3km0xva2VWBn+kbJ+jLAI
	 eocJXMl6dYuB5V9QWaIEXsOn+xl/b0+VDq0XMT+ai99cmgilz78VKhoBBYgskJv3I2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794671011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/8Am712/UKZMknyahwOgZ7GXCeTB3l6oZgw5VLnohk4=;
	b=PR+iht9y/bTsR0mrhqXOt+DZeX2gWKrF5x9YRvoLGFo+2ZSwVG8KuD4obcM8xZJFYGIj
	 e9UGSJSCTHpcPG4PU7Mwo7r9yQZr5BRVRlewPz1Izv3oi0pP0Lpmb4W6QFAsa9wyESCuO
	 Abg9wsbbar8FihwltaBS7drH0TBJCZqK0Pd/OV0121jNvL0MY0h88NPvPADrJoHzH5Fq+
	 UGe5y+zaw1f2B7VfcoiEaIPRuwh45d3YcwzIywr7OvAGDKNZyxRzLcePB5wUR2BCWIIjk
	 MDVRlMoWHlFDmcqUIK59CqNC1j83O9EWzhfa79BILvq4cm50rWumPjXRItBM2hJ2hqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vEH9IuOf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0797606A334
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 15:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0797606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vEH9IuOf
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so2612204eec.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 07:43:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794671010; cv=none;
        d=google.com; s=arc-20260327;
        b=kiodUV4DPPWYGa3BqQ8EluVLAWA2bfuxBFJUQdbJZfChobekhE4QVG8cFJZ04dUedL
         wq6olzfRvjLbCTuDTr/GKRpJ4nx7BCKu8iGRz4F6ZyqNATlAGH28Qnw/W2TiZk92rxxm
         SM0jY5O+V++UN7LL/gPqqe/06Sa7uBPdrOD5jtSeCjtRb/TsTSajRA1LOAFudHmF1znL
         6BDLK3ekWuLI3yOt9lwKdwjLjoFZzsH+PotPL43ZvdDrxVXS3w3zDyI94QvWelaz2AZI
         NF9baSbfh2YyQfPW60sXwJspjArIDtkTDVYsvzW1zIO1//CRJJ57JFNMfic38wwWTYDu
         /MPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/8Am712/UKZMknyahwOgZ7GXCeTB3l6oZgw5VLnohk4=;
        fh=7eb26fUErYoLvChgyGeO9Lt5q2KyCkblEBDyVoiToY4=;
        b=F7ChA1jjR746SLV8I6wG8e2sQlW6XeEq9Vbyuh3nA2cFpX7UsLEjjS5ZuaI46WA+Ln
         I2VJHxk+zvU9zThZoCFQfjpq8RNXdeUEJI1+zqwJB+TCos2VwYHkuGBBbQYHE3RokmQv
         EfLHpepjDs0OiqLxTbxEljvC5fJwUU7RhGH5z0Q2oxCb/AeITr1R6oAGG8mK3zFTMCmk
         mEUOChNlvULV0xNeAfTXrXh8WaOGYz9MaBvAuhndmCGlWpMKCsAOt+6MC1XiRtL4UVPC
         0523tkL6k0uoxsalOlzp9vVOGP1yDM9vdgEl8l26lxQTfwcgatCxLlzRWj4ROM67gqA0
         2SiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794671010; x=1795275810; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/8Am712/UKZMknyahwOgZ7GXCeTB3l6oZgw5VLnohk4=;
        b=vEH9IuOf8TqXlFP9jIwVqQe/KNAJtF5/1hpL6sn50wQwUogRkv51QaBIzUQxFvWX5K
         SUEZKCImhTL+TVaiIplzcY379q3ZV7IMgWtzWwpZvYa/NjasxqQpWRyGurewcZHmkYn6
         EXup1ph+mGCKntgLBQVhsjDuokWH5RVxh4qw6N/JXw5tgBc31TbCHlPlq2BONvt8zO3j
         D3imt00RGdnhGifjEXXTqfk3jpbUcT25+U4fCE5CclL27JUUME/2HAf3ES3GyzH0Ram0
         0M4G4oceJTxLgQP/wID8VAxBN2w0ir3lIM8mYXdlG3xU/zOoSl6Na41oe7HB/AaYTyNz
         cohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794671010; x=1795275810;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/8Am712/UKZMknyahwOgZ7GXCeTB3l6oZgw5VLnohk4=;
        b=ZwuGEsRDriL0II3LzmE2j6R6iBGwBs2Nu3z21+msnGu771fm9CrNAmHLrgu3lErUGo
         qyr4KpSkzzwuWgYLLKyhwDtCNTk+/28lH7TIxVtwYMcxej8PikdpFCJcfpzuMOVy3Vbh
         ysm6757vNKK+nLTyN5XS7CIymjX90wRfSLbPe/VgC/znXnlUxq4voI45wI9NYfTsPBqU
         5CEEBPVGjf3k50d1pfbv8zr4UxNd8q4NY8TJwXuFvZqdKjyJH2JRalc9vvb+B5dV5wBE
         bM73oSab+qPqRC88uz/0tDRFhB5NO0dBZzOVpE/IvvfyudTwA+dbeKAi1RwWBwdk0eUh
         2K2A==
X-Forwarded-Encrypted: i=1; AL+hErEzbV+qvDREJP1nDc3g1bzHattS0KydVNzYxJ6WD+qYwYoNWkwbuHovTlnRKo5zh9TSwPMERpark9wXUe/g@vger.kernel.org
X-Gm-Message-State: APuU4Z+7wag50s+xuvvmFJqtxamJkRTtY2CV9SafUMc7QxrYsA1hvtAA
	nHKbHXi/G+sGIha8iSMM+e0N1ULe2faiH6EU0Gyit1aLrdZm5REiBCWdzUy7WB+UFcZIU1EBpQQ
	SS+TwKJthXdyy8MN6F9t9NFa3yxcJNyM=
X-Gm-Gg: AYBFou3bdPrrcQvLAsZAxfCF775VWXHSBlYnCm9PFZxthAt7gsPSajjZnIoznJ+HXPw
	0bkLaf7qrbK2tJG6O/2vea+p9Uod5CRBOBk00pCRqiicLPg2APXCNF7vzV5Jz9VwM/Cg6boz87I
	bh2q9SDoPTRk1Ei9h+kHBBNgOrxB6rJ6x+QYXXTyJakLeBnn+q5JMYOMIsW/mRHWLLVLKEvzM/h
	Vj+EQPcGSmDylJpHHjT8mbqHmw7myhrqfUDMfU3mjXOJ5priYtPzub1ygUeAG1dWEHmFMEBmCst
	YWsmMYaFhi2EF+KIWpH2qemW3bPIeTKC1rodLUQAO/i0+7ow3BkufAEywzE1h9Hc4KNFkzy64yO
	bVzlolH5VjWUkOHsLtVPGn9+o6GxgrfED/65FhS66J1ljqk6zavrF3qpL7HvaA4mWXI7EhlFYAs
	FN6EwvI1G5t014QtkPC6UydLe02iIChRkJfDJvE+1WUw==
X-Received: by 2002:a05:7300:b284:b0:35e:2c6:d46c with SMTP id
 5a478bee46e88-37966e3abf5mr6101065eec.10.1794671010025; Sat, 14 Nov 2026
 07:43:30 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAJ6F8CFSfgdZqaKMndGZtbaww32Xr_KVL3gA_2Jemgv9i9vskg@mail.gmail.com>
 <CAJ6F8CFgkgksyk6YM3NdMkQNhSFWV4depC4c-mHvpDHpnjhM-Q@mail.gmail.com> <6ab4a114-57b2-40c7-99d4-55a4ac4c9a9c@leemhuis.info>
In-Reply-To: <6ab4a114-57b2-40c7-99d4-55a4ac4c9a9c@leemhuis.info>
From: =?UTF-8?Q?Cl=C3=A9ment_Smagghe?= <cle.smagghe@gmail.com>
Date: Sat, 14 Nov 2026 16:43:19 +0100
X-Gm-Features: AclHuK9JZCuhMb1uoaKigZDdQKHU-3gJV6cHqPK13T6gU6gv_wW71frzsK9rTyg
Message-ID: <CAJ6F8CHzm4=ryY+j3ao6doR=-67Lq=3-w-kbhk1wdvtYDhyNeA@mail.gmail.com>
Subject: Re: [REGRESSION] ntfs3: existing files/dirs with ':' in their name
 became inaccessible in 7.3 (ads on by default)
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev, 
	regressions@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hungyu Lin <dennylin0707@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 11/14/26 14:11, Thorsten Leemhuis wrote:
> Thx for the reports. This sounds a lot like a problem Hungyu Lin is
> trying to fix with these patches:
>
> [PATCH] fs/ntfs3: preserve colons in symlink targets
> https://lore.kernel.org/all/20261029203457.59990-1-dennylin0707@gmail.com=
/
>
> [PATCH] fs/ntfs3: preserve colons in volume labels
> https://lore.kernel.org/all/20261029225856.1173-1-dennylin0707@gmail.com/
>
> Please look into those -- and if your's is a different problem, please
> report back.
>
> Ciao, Thorsten

Thanks, Thorsten. I looked at both patches. They share the same root
cause as my report (ntfs_nls_to_utf16() splitting names at ':' since
be310476e886), but they fix different call sites and do not cover my
case, so I believe this is a separate problem.

- "preserve colons in symlink targets" adds a parse_ads argument to
  ntfs_nls_to_utf16() and passes false only from
  ntfs_create_reparse_buffer(). All other callers explicitly keep
  parse_ads =3D true, in particular ntfs_lookup(), fill_name_de(),
  ntfs_d_hash() and ntfs_d_compare(). The commit message even says
  "Keep parsing enabled for the other callers to preserve their
  existing behavior."

- "preserve colons in volume labels" only changes ntfs_set_label()
  in fsntfs.c.

My problem is in the lookup path: an existing directory entry whose
name contains an interior ':' (e.g. "Reverse: 1999") is returned by
readdir, but ntfs_lookup() converts the name with ADS parsing still
enabled, looks up the stream " 1999" of a non-existent file
"Reverse", and fails with ENOENT. With both patches applied this
path is unchanged, so stat/open/rename/unlink on such entries would
still fail. Only mounting with 'ads=3D0' restores access.

So I think the lookup case needs its own fix, e.g. one of:
  - make 'ads' opt-in (default off), as before 7.3, or
  - in ntfs_lookup() (and the dcache hash/compare helpers), first try
    the full name as a regular directory entry and only fall back to
    the file:stream interpretation if that fails;
plus accepting 'noads' like the other options, since today only
'ads=3D0' works.

I'm happy to test patches.

Thanks,
Cl=C3=A9ment Smagghe
