Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF3A51DAE6
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 22:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201686; cv=none; b=GQYoawzG8hHbjRYrivBAyuVeEpR77Hj0WGFHmYFJz/vSx/70yadkYnRmCvsbyB1674CcOVvFmF31rrGNRzL0+BNGGVvfL747dnoBDgvpH+FmS5nIfbDfXXwC+wO9YP4zQYCaMtqP0QZGpxGYY39FxN1GaPq7obbYQTHX3HAkiPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201686; c=relaxed/simple;
	bh=9hyyX28oeoph3ynZDZOIhq81NPkDeMrwBFPPNTTwcUM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=szBXyhwHN2dprIL9rIQOWL5XzoKZMaIS0TKH5IW1Uva5RQnYA73JT5+6AuPJ+c97qsDiKOfqius1gGVmvEHYf38/wNP1NCJkvsDDc53wx8SWegSppfXqXAze0nMf51YDhq9I52SfCRsHzjvolHaNolyC21uyzt3iYXcpS5Fg6WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4ZDIe6Q; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4ZDIe6Q"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c7f7cc52efso609877e0c.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 15:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790201683; x=1790806483; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0EdqxdNUP5cyv8NzTsTlmS03OnsakLNpJMwPNRa976s=;
        b=F4ZDIe6Q4QgkEdECQ2Ez9owwKXdYcOJaT2cDQlUQvq7ctqjQ1+AX6Plf7JFlDV+B1c
         KbsoblyCowTztzLiaeAG6pOLHBeqRv2t7neaYZHXOJMNfKp4cKzws7kejz0SQk8yJ2A2
         KDmULhdfz20DAgXzpM6w//jQh4CJwG1a4KaJkMokCVj0h/usdQadS7gO5Ip31au2v2Wm
         AzkyVdQQ/Zsw9uOYnEvDGRlX9HAvPV1GXh4d0zp1Q6VKZXTiLQ483X8y6huupT48umKL
         JmnZp8RYikJa5VTXqLbqefYvWPCOjdR1tnKoutBkYzo0lya7KpCZykCKMe/L/IghcWS+
         Jo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790201683; x=1790806483;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0EdqxdNUP5cyv8NzTsTlmS03OnsakLNpJMwPNRa976s=;
        b=MN6PbyE22ppJ0mbk0lh7PSybUMOB0Gqxf7PbPNjbIb4A6lzpnRCnjZkfLRF9ofQIpw
         KMU+DBL1s13e//V4IZQPVCIBi0eGxuWlYwzDk7i3v4J2h60Mtvgmrdl3MaG8xzurxvfk
         5MTpAQ6CietsoZJq8/NxQ9V24hikvMu/OE4Hkh2yA5LBvDa/9ntMWR0sg+8x2rrQ0ndw
         hlTjkILndq/2HrXq3rd3iUPPAt5Ar8TR9T9sbdXShp3wpEieJ7DAmuo4QS0yU5Unqe2h
         2Y/V7L7bpZ//70l+zIBXa0ea/Bo2rtz3j6eiBjjCN/DDjpkVCe5NZ8apX7gvZuItSy2x
         +YMA==
X-Forwarded-Encrypted: i=1; AKwUvBzYizxBaSKBHHPeIlKrUbdcBnVu0kKoMAu6kOlGHAGfnC2JcHkSNilvYrX6wrml3KAx/78BTRTSu/qTHRwE@vger.kernel.org
X-Gm-Message-State: AFuF++mxEuXeVokCvnL470QWyxv9DS5thYpSxjmgaIOJr9XkI6Ag2cvd
	pvzQMsTaDg2VG3ZS/LrUzP/lOY9UvEku/Qtt1XyuzAu2TZJTiWrDNxKU
X-Gm-Gg: AYBFou0lVYTSSyT3SWokrccwgzJhHJmYAx+cj90CMubJzigDzU8dFXIVYDx9mAkkW4C
	nMcGo6W6k1KEGzkH2cfQE29xDeaKoFNODjst/L4RjBoInJzWeRqswnCSIy9QNi6e8ERjMHcTpXe
	MeAGM7NOmKBEn2DSJKPPV41c/jx7Y1BbPu4sQDW+WOif8WvXQ3ToPd4y1U276WyXo9SWI2i8grj
	B9gV4EMuKopfQE+/EvOvgn+2HeDb8NsLW+ft2FIwIKZusxr/J1B3BePJbZf4gyXNWbtOgWp5PAB
	OAckHK7nk4A2cMFSKEZy1lRg8zhMhciGcYVOnCJBW91ih/qys415vn20LXrJuNmOY8LTNx5NjqW
	UvpU80xGqtDZ6pcIPhkWtF9T3o/E4SBq6xRII5XiFz38h5tfyIq/Pk+VOCxWlXqCtnmpM0VtOuK
	hGqh54Hct/GS7DBIfsseQ91a/ERvxxAL+6kG/AuTC0MEaxfYbcUwMK6BAN36KJptqWpX4pkpK6H
	ZIWG4GphSehB6H+hRdcnifno1CBzwca8gL6vVKvev4FCNTHuhzyKNly1GoFwBprfCwK
X-Received: by 2002:a05:6102:508e:b0:7a3:833c:49a4 with SMTP id ada2fe7eead31-7af1eff6910mr462129137.26.1790201683185;
        Wed, 23 Sep 2026 15:14:43 -0700 (PDT)
Received: from bazzite ([138.122.221.5])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7abf5c6d7b2sm6071173137.8.2026.09.23.15.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:14:42 -0700 (PDT)
Date: Wed, 23 Sep 2026 19:14:21 -0300 (-03)
From: Davy Felipe <davyfelipe34@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Davy Felipe <davyfelipe34@gmail.com>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Yangtao Li <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hfs: handle extent B-tree write errors
In-Reply-To: <c569d5f8ee542e5c86a7e4dee23df99f4ec0becd.camel@dubeyko.com>
Message-ID: <44cf540b-6d33-845d-4943-6b65959730f5@gmail.com>
References: <20260920160213.285316-1-davyfelipe34@gmail.com> <20260922234039.1307375-1-davyfelipe34@gmail.com> <c569d5f8ee542e5c86a7e4dee23df99f4ec0becd.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463806207-502084886-1790201682=:1721090"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463806207-502084886-1790201682=:1721090
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hi Slava,

Thanks for the feedback.

Yes, I agree. A small reusable check helper would make the code cleaner
and avoid duplicating the range validation.

Regarding hfs_bnode_write(), I also agree that its current void
interface makes proper error handling difficult. Converting it to
return an error code and auditing its callers looks like the right
direction for a follow-up refactoring.

For this patch, I will keep the change small, introduce the reusable
check helper, and send a v3.

I would be happy to work on the hfs_bnode_write() refactoring as a
follow-up as well.

Thanks,
Davy Felipe

On Wed, 23 Sep 2026, Viacheslav Dubeyko wrote:

> On Tue, 2026-09-22 at 20:40 -0300, Davy Felipe wrote:
>> __hfs_ext_write_extent() does not report all failures while updating
>> the extents B-tree.
>>
>> When inserting a new extent record, the return value of
>> hfs_brec_insert() is ignored and HFS_FLG_EXT_DIRTY and
>> HFS_FLG_EXT_NEW
>> are cleared even if the insertion fails.
>>
>> When updating an existing extent record, hfs_bnode_write() returns
>> void, so its caller cannot detect a rejected write. Validate the
>> extent
>> record size and node range before calling hfs_bnode_write().
>>
>> Propagate errors returned by hfs_brec_insert() and return -EIO for an
>> invalid existing extent record. Only clear the extent dirty flags
>> after
>> a successful operation.
>>
>> Fault injection confirmed both failure paths. Insertion errors are
>> propagated to the caller, and invalid existing-record writes are
>> rejected before hfs_bnode_write() without clearing the dirty state.
>>
>> Signed-off-by: Davy Felipe <davyfelipe34@gmail.com>
>>
>> Changes in v2:
>> - Validate the existing extent record size and node range before
>>   calling hfs_bnode_write(), following review feedback.
>> - Return -EIO without clearing HFS_FLG_EXT_DIRTY when validation
>>   fails.
>> - Fault-injection tested the existing-record failure path. Before the
>>   change, hfs_bnode_write() rejected an invalid offset internally but
>>   __hfs_ext_write_extent() continued and cleared the dirty flag. With
>>   v2, the invalid write is rejected before hfs_bnode_write().
>>
>> ---
>>  fs/hfs/extent.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
>> index f066a99a863b..13426503fbb3 100644
>> --- a/fs/hfs/extent.c
>> +++ b/fs/hfs/extent.c
>> @@ -121,12 +121,21 @@ static int __hfs_ext_write_extent(struct inode
>> *inode, struct hfs_find_data *fd)
>>  		res = hfs_bmap_reserve(fd->tree, fd->tree->depth +
>> 1);
>>  		if (res)
>>  			return res;
>> -		hfs_brec_insert(fd, HFS_I(inode)->cached_extents,
>> sizeof(hfs_extent_rec));
>> +		res = hfs_brec_insert(fd, HFS_I(inode)-
>>> cached_extents,
>> +				      sizeof(hfs_extent_rec));
>> +		if (res)
>> +			return res;
>>  		HFS_I(inode)->flags &=
>> ~(HFS_FLG_EXT_DIRTY|HFS_FLG_EXT_NEW);
>>  	} else {
>>  		if (res)
>>  			return res;
>> -		hfs_bnode_write(fd->bnode, HFS_I(inode)-
>>> cached_extents, fd->entryoffset, fd->entrylength);
>> +		if (fd->entrylength != sizeof(hfs_extent_rec) ||
>> +		    fd->entryoffset < 0 ||
>> +		    (u64)fd->entryoffset + fd->entrylength >
>> +			    fd->tree->node_size)
>
> I think it will be better to introduce a small check function that can
> be reused then. And code will be cleaner here. What do you think?
>
>> +			return -EIO;
>> +		hfs_bnode_write(fd->bnode, HFS_I(inode)-
>>> cached_extents,
>> +				fd->entryoffset, fd->entrylength);
>
> I see that you are trying not to go into huge modification. But,
> frankly speaking, I believe we need the refactoring of
> hfs_bnode_write() calling. This function should return error code and
> we need to process this error code in other methods. Maybe, future
> refactoring work for you? ;)
>
> Thanks,
> Slava.
>
>>  		HFS_I(inode)->flags &= ~HFS_FLG_EXT_DIRTY;
>>  	}
>>  	return 0;
>
---1463806207-502084886-1790201682=:1721090--
