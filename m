Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51D840DFDB;
	Thu, 30 Apr 2026 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509375; cv=none; b=Z2nvFC2wheFXjlRH8iR0lUpFBaAgqpTHEIYvDqa/XYOv4Bv0xbVNQF0qUsx4GfOVVFXKrkfZ3u1/yE5kVc6Qa9KHXTqc51C5Q+9uv8hzFeMpp2+cw/tDzRdzXeLeI9yxV+Y1j9hlvpxdqxs5UAPGbcYfqKGagUqIKPJ7xosgeEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509375; c=relaxed/simple;
	bh=tpzsN0JWkujhum5ypZyRd6xbSgB/sHmGL101UkNnqac=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=cbu/+GtafyqfEHuPaE0amnP0gBD3WgE5nMo2jRNej5gt2uvOiwV7NjmUgHMppfw1ivVwgRL0P4wyv071NhU7CzDljZI4W5l0kE55pn6cH4HnBMjsExONqpN9wuUnFZNiZS5AaCpFpnHx6ukl4TUkS6gwcuuJjpL9sE0kCMVjHd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 7FD061D459;
	Thu, 30 Apr 2026 00:36:03 +0000 (UTC)
Received: from [192.168.1.18] ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id AaspC/Oj8mknvwUA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Thu, 30 Apr 2026 00:36:03 +0000
Message-ID: <d7edfeab-af06-4b2d-a085-f8eef077e877@dev.snart.me>
Date: Thu, 30 Apr 2026 09:36:00 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: David Timber <dxdt@dev.snart.me>
Subject: [RFC] determining if the underlying storage device of blockdev is
 "real", the Linux modern way
To: driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>,
 Yuezhang Mo <yuezhang.mo@sony.com>
Content-Language: en-US, ko
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello maintainers,

https://github.com/exfatprogs/exfatprogs/pull/351

I'm currently implementing a feature in exfatprogs to fix a long
standing compatibility issue with MS Windows systems. mkfs.exfat was
missing a crucial feature and that lead to compatibility issues reported
by users.

*Background*

There exist two different authoritative exFAT specifications by two
different organisations: one being Microsoft and the other being the SD
Association. As Brauner said years ago when the exFAT implementation has
been introduced to the mainline, Microsoft's exFAT specs remain largely
incomplete and my humble personal view is that the specs by the SD
Association is more mature. However, the SD specs are still locked
behind the paywall to this day so it's hard for the file system devs to
implement to the spec. Nonetheless, the fact that there exist two
different specs lead opensource implementations of exFAT to become a
kind of amalgamation of the two and exfatprogs and the in-kernel exFAT
fs were no exception.

Let me bring your attention to dosfstools, which has played an important
role for supporting UEFI on Linux therefore has been shipped with many
distros as long as the Linux community can remember.

MKFS.FAT(8):
...
>        --mbr[=y|yes|n|no|a|auto]
>            Fill (fake) MBR table with disk signature one partition
> which starts at sector 0 (includes MBR itself) and spans whole disk
> device.  It is needed only for non-removable disks used on Microsoft
> Windows  systems  and  only  when formatting  whole  unpartitioned
> disk.  Location of the disk signature and partition table overlaps
> with the end of the first FAT sector (boot code location), therefore
> there is no additional space usage.  Default is auto mode in which
> mkfs.fat put MBR table only for non-removable disks when formatting
> whole unpartitioned disk.
...

It is evident from the manpage that MS Window systems had issues
recognising "removable" disks formatted without MBR. From the personal
observations I made, this still remains true in recent releases of
Windows don't seem to recognise "fixed"
devices(/sys/dev/block/*/removable reads 0) formatted without MBR.

https://github.com/dosfstools/dosfstools/commit/5199d6847a5e183800fc356abcb2e2ea5fb8fa01
https://github.com/dosfstools/dosfstools/blob/289a48b9cb5b3c589391d28aa2515c325c932c7a/src/device_info.c#L109

Diving into the source code, we can see that mkfs.fat does its best to
figure out if the device associated with a "real" physical device and if
the device is NOT removable, mkfs.fat deems that the device needs the
MBR region to be filled so that the volume can be recognised and used on
MS Windows systems.

https://aussiestorageblog.wordpress.com/2013/11/11/your-sandisk-usb-stick-is-no-longer-removable-and-its-microsofts-fault/

For your information, the "removable" attribute comes from the device
itself via SCSI RMB bit(UAS uses as its underlying transport protocol).
So, whether the storage is actually removable or not has nothing to do
with the actual type of the storage. If the USB stick advertises itself
as "removable", then it is removable. If it doesn't, it's not. For
example, the MMC interface doesn't have the corresponding attribute so
"removable" in sysfs always reads as 0 although you'd think that MMC
media are removable.

The problem is that MS Windows kernel treats "removable" and "fixed"
storage devices differently. If the device is removable, it's not
required to have MBR. MS Windows will detect the volume with or without
MBR. But in case of "fixed"(RMB unset), MS Windows kernel will treat the
device uninitialised if it doesn't contain an MBR. We can all agree that
this behaviour has some serious consequences, but the problem remains
corrected in recent release of Windows.

Ironically, despite the quirk of their own implementation, MS's version
of exFAT specs do not mandate the use of MBR, which lead to
compatibility issues with mkfs.exfat. On the other hand, SD
associations' specs clearly recommends the use of MBR regardless of the
type of device.

The recursive MBR partition entry approach has its own potential
issues(parted actually can't handle recursive partitions other than that
of vFAT and nukes the entries of exFAT boot sector without any prompts).
So when it's not required, it's best not to put one to be on the safe
side. Besides, Linux kernel partscanning the MBR and a partition being
create after runinng mkfs.fat is definitely confusing for many users as
well as other fs utils.

*Question*

The existing dosfstools implementation juggles through the sysfs tree to
see if the device has "children" or "slaves", or if the device is
dm(RAID/dm-crypt ...) or loopdev. If any of the condition is true, the
device is considered "virtual" and no MBR partition entries will be
written for the new volume.

https://github.com/exfatprogs/exfatprogs/pull/351/changes/25bea15e3e229bf2661392d0f960c28ab3badf0e

I believe that this is mostly redundant and the code required to do this
is not so straightforwrad. Using the fairly modern kernel(post-2.6), I
think it can be simplified to:

  * has /sys/dev/block/*/partition and reads integer value > 0: then
    it's a partition so MBR not required
  * has /sys/dev/block/*/device symlink: then it's definitely a real
    physical device
  * but if there's entries in /sys/dev/block/*/slaves: then it's
    "virtual" device

And maybe add

  * /sys/dev/block/*/start reads > 0: then it's a partition or a some
    sort of slave

So symlink dereferencing, no visiting parent directories and so on.

The whole point of doing this is to write MBR only to "real" storage
devices that may be connected to MS Windows systems later. More
specifically: when running mkfs.exfat on a HDD/SDD/SATA/NVME/USB(UAS) drive.

What did I miss? Would this be good enough heuristics? Or any better way
to achieve this?

Thanks,
Davo
